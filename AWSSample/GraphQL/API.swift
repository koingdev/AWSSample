//  This file was automatically generated and should not be edited.

import Apollo

public final class DiariesQuery: GraphQLQuery {
  public let operationDefinition =
    "query Diaries($author: String) {\n  diaries(author: $author) {\n    __typename\n    ...diary\n  }\n}"

  public var queryDocument: String { return operationDefinition.appending(Diary.fragmentDefinition) }

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

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(diaries: [Diary?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "diaries": diaries.flatMap { (value: [Diary?]) -> [ResultMap?] in value.map { (value: Diary?) -> ResultMap? in value.flatMap { (value: Diary) -> ResultMap in value.resultMap } } }])
    }

    public var diaries: [Diary?]? {
      get {
        return (resultMap["diaries"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Diary?] in value.map { (value: ResultMap?) -> Diary? in value.flatMap { (value: ResultMap) -> Diary in Diary(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [Diary?]) -> [ResultMap?] in value.map { (value: Diary?) -> ResultMap? in value.flatMap { (value: Diary) -> ResultMap in value.resultMap } } }, forKey: "diaries")
      }
    }

    public struct Diary: GraphQLSelectionSet {
      public static let possibleTypes = ["Diary"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("title", type: .scalar(String.self)),
        GraphQLField("author", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, title: String? = nil, author: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "Diary", "id": id, "title": title, "author": author])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var title: String? {
        get {
          return resultMap["title"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "title")
        }
      }

      public var author: String? {
        get {
          return resultMap["author"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "author")
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

        public var diary: Diary {
          get {
            return Diary(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }
  }
}

public final class InsertDiaryMutation: GraphQLMutation {
  public let operationDefinition =
    "mutation InsertDiary($id: ID!, $title: String, $author: String) {\n  insertDiary(id: $id, title: $title, author: $author) {\n    __typename\n    ...diary\n  }\n}"

  public var queryDocument: String { return operationDefinition.appending(Diary.fragmentDefinition) }

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

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(insertDiary: InsertDiary? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "insertDiary": insertDiary.flatMap { (value: InsertDiary) -> ResultMap in value.resultMap }])
    }

    public var insertDiary: InsertDiary? {
      get {
        return (resultMap["insertDiary"] as? ResultMap).flatMap { InsertDiary(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "insertDiary")
      }
    }

    public struct InsertDiary: GraphQLSelectionSet {
      public static let possibleTypes = ["Diary"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("title", type: .scalar(String.self)),
        GraphQLField("author", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, title: String? = nil, author: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "Diary", "id": id, "title": title, "author": author])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var title: String? {
        get {
          return resultMap["title"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "title")
        }
      }

      public var author: String? {
        get {
          return resultMap["author"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "author")
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

        public var diary: Diary {
          get {
            return Diary(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }
  }
}

public final class OnSubscribeSubscription: GraphQLSubscription {
  public let operationDefinition =
    "subscription OnSubscribe($author: String) {\n  onSubscribe(author: $author) {\n    __typename\n    ...diary\n  }\n}"

  public var queryDocument: String { return operationDefinition.appending(Diary.fragmentDefinition) }

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

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(onSubscribe: OnSubscribe? = nil) {
      self.init(unsafeResultMap: ["__typename": "Subscription", "onSubscribe": onSubscribe.flatMap { (value: OnSubscribe) -> ResultMap in value.resultMap }])
    }

    public var onSubscribe: OnSubscribe? {
      get {
        return (resultMap["onSubscribe"] as? ResultMap).flatMap { OnSubscribe(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "onSubscribe")
      }
    }

    public struct OnSubscribe: GraphQLSelectionSet {
      public static let possibleTypes = ["Diary"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("title", type: .scalar(String.self)),
        GraphQLField("author", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, title: String? = nil, author: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "Diary", "id": id, "title": title, "author": author])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var title: String? {
        get {
          return resultMap["title"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "title")
        }
      }

      public var author: String? {
        get {
          return resultMap["author"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "author")
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

        public var diary: Diary {
          get {
            return Diary(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }
  }
}

public struct Diary: GraphQLFragment {
  public static let fragmentDefinition =
    "fragment diary on Diary {\n  __typename\n  id\n  title\n  author\n}"

  public static let possibleTypes = ["Diary"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
    GraphQLField("title", type: .scalar(String.self)),
    GraphQLField("author", type: .scalar(String.self)),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: GraphQLID, title: String? = nil, author: String? = nil) {
    self.init(unsafeResultMap: ["__typename": "Diary", "id": id, "title": title, "author": author])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var id: GraphQLID {
    get {
      return resultMap["id"]! as! GraphQLID
    }
    set {
      resultMap.updateValue(newValue, forKey: "id")
    }
  }

  public var title: String? {
    get {
      return resultMap["title"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "title")
    }
  }

  public var author: String? {
    get {
      return resultMap["author"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "author")
    }
  }
}