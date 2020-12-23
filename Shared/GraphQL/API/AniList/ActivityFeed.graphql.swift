// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class ActivityFeedQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query ActivityFeed($page: Int!, $isFollowing: Boolean!, $hasRepliesOrTypeText: Boolean!, $includeBuggyFields: Boolean!) {
      Page(page: $page, perPage: 50) {
        __typename
        activities(
          isFollowing: $isFollowing
          hasRepliesOrTypeText: $hasRepliesOrTypeText
          sort: [ID_DESC]
          type_in: [TEXT, ANIME_LIST, MANGA_LIST]
        ) {
          __typename
          ... on TextActivity {
            ...textActivityFragment
          }
          ... on ListActivity {
            ...listActivityFragment
          }
        }
      }
    }
    """

  public let operationName: String = "ActivityFeed"

  public var queryDocument: String { return operationDefinition.appending("\n" + TextActivityFragment.fragmentDefinition).appending("\n" + ListActivityFragment.fragmentDefinition) }

  public var page: Int
  public var isFollowing: Bool
  public var hasRepliesOrTypeText: Bool
  public var includeBuggyFields: Bool

  public init(page: Int, isFollowing: Bool, hasRepliesOrTypeText: Bool, includeBuggyFields: Bool) {
    self.page = page
    self.isFollowing = isFollowing
    self.hasRepliesOrTypeText = hasRepliesOrTypeText
    self.includeBuggyFields = includeBuggyFields
  }

  public var variables: GraphQLMap? {
    return ["page": page, "isFollowing": isFollowing, "hasRepliesOrTypeText": hasRepliesOrTypeText, "includeBuggyFields": includeBuggyFields]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("Page", arguments: ["page": GraphQLVariable("page"), "perPage": 50], type: .object(Page.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(page: Page? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "Page": page.flatMap { (value: Page) -> ResultMap in value.resultMap }])
    }

    public var page: Page? {
      get {
        return (resultMap["Page"] as? ResultMap).flatMap { Page(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "Page")
      }
    }

    public struct Page: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Page"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("activities", arguments: ["isFollowing": GraphQLVariable("isFollowing"), "hasRepliesOrTypeText": GraphQLVariable("hasRepliesOrTypeText"), "sort": ["ID_DESC"], "type_in": ["TEXT", "ANIME_LIST", "MANGA_LIST"]], type: .list(.object(Activity.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(activities: [Activity?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "Page", "activities": activities.flatMap { (value: [Activity?]) -> [ResultMap?] in value.map { (value: Activity?) -> ResultMap? in value.flatMap { (value: Activity) -> ResultMap in value.resultMap } } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var activities: [Activity?]? {
        get {
          return (resultMap["activities"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Activity?] in value.map { (value: ResultMap?) -> Activity? in value.flatMap { (value: ResultMap) -> Activity in Activity(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Activity?]) -> [ResultMap?] in value.map { (value: Activity?) -> ResultMap? in value.flatMap { (value: Activity) -> ResultMap in value.resultMap } } }, forKey: "activities")
        }
      }

      public struct Activity: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["TextActivity", "ListActivity", "MessageActivity"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLTypeCase(
              variants: ["TextActivity": AsTextActivity.selections, "ListActivity": AsListActivity.selections],
              default: [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              ]
            )
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public static func makeMessageActivity() -> Activity {
          return Activity(unsafeResultMap: ["__typename": "MessageActivity"])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var asTextActivity: AsTextActivity? {
          get {
            if !AsTextActivity.possibleTypes.contains(__typename) { return nil }
            return AsTextActivity(unsafeResultMap: resultMap)
          }
          set {
            guard let newValue = newValue else { return }
            resultMap = newValue.resultMap
          }
        }

        public struct AsTextActivity: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["TextActivity"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLFragmentSpread(TextActivityFragment.self),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var fragments: Fragments {
            get {
              return Fragments(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }

          public struct Fragments {
            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public var textActivityFragment: TextActivityFragment {
              get {
                return TextActivityFragment(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }
          }
        }

        public var asListActivity: AsListActivity? {
          get {
            if !AsListActivity.possibleTypes.contains(__typename) { return nil }
            return AsListActivity(unsafeResultMap: resultMap)
          }
          set {
            guard let newValue = newValue else { return }
            resultMap = newValue.resultMap
          }
        }

        public struct AsListActivity: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["ListActivity"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLFragmentSpread(ListActivityFragment.self),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var fragments: Fragments {
            get {
              return Fragments(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }

          public struct Fragments {
            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public var listActivityFragment: ListActivityFragment {
              get {
                return ListActivityFragment(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }
          }
        }
      }
    }
  }
}
