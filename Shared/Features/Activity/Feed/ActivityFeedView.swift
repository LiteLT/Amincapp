//
//  ActivityFeedView.swift
//  Amincapp (iOS)
//
//  Created by Kyle Erhabor on 1/31/21.
//

import SwiftUI

struct ActivityFeedView: View {
    @StateObject private var viewModel = ActivityFeedViewModel()
    @State private var tab = ActivityFeedTab.global
    @State private var isPresenting = false
    @State private var page = 1

    var body: some View {
        // FIXME: An action that would mutate the activity instance is not saved upon the list being rerendered. This
        // is due to Swift's pass-by-value nature with function parameters. If attempted, it would require a lot of
        // uses of `inout` to propogate it up the view stack to a non-view closure.
        //
        // It would be easy to create a `like` method on `ActivityFeedViewModel`, but an activity list, text, or
        // message may have different features and requirements. The view (`Activity<T>View`) is also constructable
        // outside the activity feed (for example, a user's activity feed) to avoid rewriting the look.
        //
        // It's unknown whether this structure will work to solve this problem, but it should be fixed before
        // production. Although it's probably not uncommon to not see an activity after liking and scrolling up/down,
        // it may confuse the user.
        List(Array(viewModel.activities.enumerated()), id: \.element.id) { (index, activity) in
            ScrollView {
                ActivityFeedSelectionView(activity: activity)
                    .padding(8)
                    .onAppear {
                        if index == viewModel.activities.count - 1 && viewModel.pageInfo?.hasNextPage == true {
                            page += 1
                            viewModel.next(page: page, isFollowing: tab == .following)
                        }
                    }
            }
        }.listStyle(PlainListStyle())
        .navigationTitle("Activity Feed")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isPresenting = true
                } label: {
                    Image(systemName: "line.horizontal.3.decrease.circle")
                }
            }
        }.sheet(isPresented: $isPresenting) {
            viewModel.load(isFollowing: tab == .following)
        } content: {
            ActivityFeedFilterView(tab: $tab)
        }.onAppear {
            viewModel.load(isFollowing: tab == .following)
        }
    }
}

fileprivate struct ActivityFeedSelectionView: View {
    private(set) var activity: ActivityFeedQuery.Data.Page.Activity

    var body: some View {
        if let list = activity.asListActivity?.fragments.listActivityFragment {
            ActivityListView(viewModel: ActivityListViewModel(activity: list))
        } else if activity.asTextActivity?.fragments.textActivityFragment != nil {
            ActivityTextView()
        }
    }
}

struct ActivityFeedView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityFeedView()
    }
}
