//  This file was automatically generated and should not be edited.

import AWSAppSync

public final class DiariesQuery: GraphQLQuery {
  public static let operationString =
    "query Diaries {\n  allDiaries {\n    __typename\n    id\n    title\n    author\n  }\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("allDiaries", type: .list(.object(AllDiary.selections))),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(allDiaries: [AllDiary?]? = nil) {
      self.init(snapshot: ["__typename": "Query", "allDiaries": allDiaries.flatMap { $0.map { $0.flatMap { $0.snapshot } } }])
    }

    public var allDiaries: [AllDiary?]? {
      get {
        return (snapshot["allDiaries"] as? [Snapshot?]).flatMap { $0.map { $0.flatMap { AllDiary(snapshot: $0) } } }
      }
      set {
        snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "allDiaries")
      }
    }

    public struct AllDiary: GraphQLSelectionSet {
      public static let possibleTypes = ["Diary"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("title", type: .scalar(String.self)),
        GraphQLField("author", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID, title: String? = nil, author: String? = nil) {
        self.init(snapshot: ["__typename": "Diary", "id": id, "title": title, "author": author])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var title: String? {
        get {
          return snapshot["title"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "title")
        }
      }

      public var author: String? {
        get {
          return snapshot["author"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "author")
        }
      }
    }
  }
}

public final class InsertDiaryMutation: GraphQLMutation {
  public static let operationString =
    "mutation InsertDiary($id: ID!, $title: String, $author: String) {\n  insertDiary(id: $id, title: $title, author: $author) {\n    __typename\n    id\n    title\n    author\n  }\n}"

  public var id: GraphQLID
  public var title: String?
  public var author: String?

  public init(id: GraphQLID, title: String? = nil, author: String? = nil) {
    self.id = id
    self.title = title
    self.author = author
  }

  public var variables: GraphQLMap? {
    return ["id": id, "title": title, "author": author]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("insertDiary", arguments: ["id": GraphQLVariable("id"), "title": GraphQLVariable("title"), "author": GraphQLVariable("author")], type: .object(InsertDiary.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(insertDiary: InsertDiary? = nil) {
      self.init(snapshot: ["__typename": "Mutation", "insertDiary": insertDiary.flatMap { $0.snapshot }])
    }

    public var insertDiary: InsertDiary? {
      get {
        return (snapshot["insertDiary"] as? Snapshot).flatMap { InsertDiary(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "insertDiary")
      }
    }

    public struct InsertDiary: GraphQLSelectionSet {
      public static let possibleTypes = ["Diary"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("title", type: .scalar(String.self)),
        GraphQLField("author", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID, title: String? = nil, author: String? = nil) {
        self.init(snapshot: ["__typename": "Diary", "id": id, "title": title, "author": author])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var title: String? {
        get {
          return snapshot["title"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "title")
        }
      }

      public var author: String? {
        get {
          return snapshot["author"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "author")
        }
      }
    }
  }
}

public final class OnInsertSubscription: GraphQLSubscription {
  public static let operationString =
    "subscription OnInsert($author: String) {\n  onInsert(author: $author) {\n    __typename\n    id\n    title\n    author\n  }\n}"

  public var author: String?

  public init(author: String? = nil) {
    self.author = author
  }

  public var variables: GraphQLMap? {
    return ["author": author]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Subscription"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("onInsert", arguments: ["author": GraphQLVariable("author")], type: .object(OnInsert.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(onInsert: OnInsert? = nil) {
      self.init(snapshot: ["__typename": "Subscription", "onInsert": onInsert.flatMap { $0.snapshot }])
    }

    public var onInsert: OnInsert? {
      get {
        return (snapshot["onInsert"] as? Snapshot).flatMap { OnInsert(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "onInsert")
      }
    }

    public struct OnInsert: GraphQLSelectionSet {
      public static let possibleTypes = ["Diary"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("title", type: .scalar(String.self)),
        GraphQLField("author", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID, title: String? = nil, author: String? = nil) {
        self.init(snapshot: ["__typename": "Diary", "id": id, "title": title, "author": author])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var title: String? {
        get {
          return snapshot["title"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "title")
        }
      }

      public var author: String? {
        get {
          return snapshot["author"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "author")
        }
      }
    }
  }
}

public final class OnUpdateSubscription: GraphQLSubscription {
  public static let operationString =
    "subscription OnUpdate($author: String) {\n  onUpdate(author: $author) {\n    __typename\n    id\n    title\n    author\n  }\n}"

  public var author: String?

  public init(author: String? = nil) {
    self.author = author
  }

  public var variables: GraphQLMap? {
    return ["author": author]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Subscription"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("onUpdate", arguments: ["author": GraphQLVariable("author")], type: .object(OnUpdate.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(onUpdate: OnUpdate? = nil) {
      self.init(snapshot: ["__typename": "Subscription", "onUpdate": onUpdate.flatMap { $0.snapshot }])
    }

    public var onUpdate: OnUpdate? {
      get {
        return (snapshot["onUpdate"] as? Snapshot).flatMap { OnUpdate(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "onUpdate")
      }
    }

    public struct OnUpdate: GraphQLSelectionSet {
      public static let possibleTypes = ["Diary"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("title", type: .scalar(String.self)),
        GraphQLField("author", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID, title: String? = nil, author: String? = nil) {
        self.init(snapshot: ["__typename": "Diary", "id": id, "title": title, "author": author])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var title: String? {
        get {
          return snapshot["title"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "title")
        }
      }

      public var author: String? {
        get {
          return snapshot["author"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "author")
        }
      }
    }
  }
}