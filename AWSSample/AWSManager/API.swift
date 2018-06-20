//  This file was automatically generated and should not be edited.

import AWSAppSync

public final class DiariesQuery: GraphQLQuery {
  public static let operationString =
    "query Diaries($author: String) {\n  diaries(author: $author) {\n    __typename\n    id\n    title\n    author\n  }\n}"

  public var author: String?

  public init(author: String? = nil) {
    self.author = author
  }

  public var variables: GraphQLMap? {
    return ["author": author]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("diaries", arguments: ["author": GraphQLVariable("author")], type: .list(.object(Diary.selections))),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(diaries: [Diary?]? = nil) {
      self.init(snapshot: ["__typename": "Query", "diaries": diaries.flatMap { $0.map { $0.flatMap { $0.snapshot } } }])
    }

    public var diaries: [Diary?]? {
      get {
        return (snapshot["diaries"] as? [Snapshot?]).flatMap { $0.map { $0.flatMap { Diary(snapshot: $0) } } }
      }
      set {
        snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "diaries")
      }
    }

    public struct Diary: GraphQLSelectionSet {
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

public final class OnSubscribeSubscription: GraphQLSubscription {
  public static let operationString =
    "subscription OnSubscribe($author: String) {\n  onSubscribe(author: $author) {\n    __typename\n    id\n    title\n    author\n  }\n}"

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
      GraphQLField("onSubscribe", arguments: ["author": GraphQLVariable("author")], type: .object(OnSubscribe.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(onSubscribe: OnSubscribe? = nil) {
      self.init(snapshot: ["__typename": "Subscription", "onSubscribe": onSubscribe.flatMap { $0.snapshot }])
    }

    public var onSubscribe: OnSubscribe? {
      get {
        return (snapshot["onSubscribe"] as? Snapshot).flatMap { OnSubscribe(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "onSubscribe")
      }
    }

    public struct OnSubscribe: GraphQLSelectionSet {
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
