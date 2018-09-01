//
//  Apollo.swift
//  AWSSample
//
//  Created by KoingDev on 6/14/18.
//  Copyright © 2018 KoingDev. All rights reserved.
//

import Apollo
import Reachability
import RealmSwift

enum OperationStatus {
    
    case ONLINE
    case OFFLINE
    
}

private class OfflineMutation: Object {
    
    
    
}

final class Apollo {
    
    static let instance = Apollo()
    private lazy var queue = DispatchQueue(label: "ApolloRealm")
    private lazy var realm = try! Realm()
    private var operationStatus = OperationStatus.ONLINE
    private var client: ApolloClient {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Content-Type" : "application/json"]
//        configuration.httpAdditionalHeaders = ["x-api-key" : API_KEY]
        configuration.httpAdditionalHeaders = ["authorization" : CognitoAuthProvider.getLatestAuthToken()]
        let networkTransport = HTTPNetworkTransport(url: endPointURL, configuration: configuration)
        let apollo = ApolloClient(networkTransport: networkTransport)
        return apollo
    }
    
    private init() {
        NetworkListener.sharedInstance.startMonitoring(listener: self)
//        realm.schema.objectSchema.map { print($0.className) }
    }
    
}

extension Apollo {
    
    func perform<Mutation: GraphQLMutation>(mutation: Mutation, realmCaching: Object, completion: @escaping () -> Void) {
//        if operationStatus == .ONLINE {
            client.perform(mutation: mutation) { [unowned self] result, error in
                if error == nil {
                    self.queue.async {
                        try! self.realm.write {
                            self.realm.add(realmCaching)
                        }
                    }
                    completion()
                } else {
                    // error
                }
            }
//        } else {
//            realmCaching()
//        }
    }
    
    func fetch<Query: GraphQLQuery>(query: Query, completion: @escaping (Query.Data) -> Void) {
        client.fetch(query: query) { result, error in
            if let result = result?.data {
                completion(result)
            } else {
                // error
            }
        }
    }
    
}

extension Apollo: NetworkStatusListener {
    
    func networkStatusDidChange(status: Reachability.Connection) {
        switch status {
        case .none:
            operationStatus = .OFFLINE
        default:
            operationStatus = .ONLINE
        }
    }
    
}
