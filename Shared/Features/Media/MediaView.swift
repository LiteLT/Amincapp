//
//  MediaView.swift
//  Amincapp
//
//  Created by Kyle Erhabor on 11/23/20.
//

import SDWebImageSwiftUI
import SwiftUI

struct MediaView: View {
    @EnvironmentObject private var currentUser: CurrentUser
    @StateObject var viewModel: MediaViewModel
    @State private var isPresenting = false

    var body: some View {
        ScrollView {
            MediaSectionHeaderView()

            Group {
                MediaSectionSummaryView()
                Divider()
                MediaSectionTitleView()
                Divider()
                MediaSectionExternalLinksView()
            }.padding()
            .offset(y: -100)
        }.environmentObject(viewModel)
        .navigationTitle("\(viewModel.media?.title?.userPreferred ?? "")")
        .navigationBarTitleDisplayMode(.inline)
        .edgesIgnoringSafeArea([.top, .horizontal])
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isPresenting = true
                } label: {
                    Image(systemName: "pencil.circle")
                }
            }
        }.onAppear {
            viewModel.fetchMedia()
        }.sheet(isPresented: $isPresenting) {
            if let id = viewModel.media?.id {
                MediaEditorView(viewModel: MediaEditorViewModel(id: id))
                    .environmentObject(currentUser)
            }
        }
    }
}
