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

enum ConnectionState {
    case ONLINE
    case OFFLINE
}

//private class OfflineMutation: Object {
//    
//    
//    
//}

final class Apollo {
    
    static let instance = Apollo()
    var connectionState = ConnectionState.ONLINE
//    let realmThread: ThreadFIFO = {
//        return ThreadFIFO()
//    }()
    
    var client: ApolloClient {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Content-Type" : "application/json"]
//        configuration.httpAdditionalHeaders = ["x-api-key" : API_KEY]
        configuration.httpAdditionalHeaders = ["authorization" : CognitoAuthProvider.getLatestAuthToken()]
        let networkTransport = HTTPNetworkTransport(url: endPointURL, configuration: configuration)
        let apollo = ApolloClient(networkTransport: networkTransport)
        return apollo
    }
    
    private init() {
        NetworkListener.instance.startMonitoring(listener: self, endPointURL: endPointURL)
//        realm.schema.objectSchema.map { print($0.className) }
    }
    
}

extension Apollo {
    
    func perform<Mutation: GraphQLMutation>(mutation: Mutation, realmCaching: Object, completion: @escaping () -> Void) {
        RealmThreadSafe.instance.write(realmCaching, mutation: mutation, completion: completion)
//        client.perform(mutation: mutation) { result, error in
//            let block = {
//                debugPrint(Thread.current)
//                try! RealmThreadSafe.instance.realm.write {
//                    // add or update
//                    self.realmThread.realm.add(realmCaching, update: true)
//                }
//            }
            
            
//            RealmThreadSafe.instance.enqueue {
//                try! RealmThreadSafe.instance.realm.write {
//                    // add or update
//                    RealmThreadSafe.instance.realm.add(realmCaching, update: true)
//                }
//            }
//            self.realmThread.enqueue(block: block)
//            DispatchQueue.main.async {
//                if error == nil {
//                    completion()
//                } else {
//                     // error
//                }
//            }
//        }
    }
    
    func fetch<Query: GraphQLQuery>(query: Query, completion: @escaping (Query.Data) -> Void) {
        if connectionState == .ONLINE {
            client.fetch(query: query) { result, error in
                if let result = result?.data {
                    completion(result)
                } else {
                    // error
                }
            }
        } else {
            
        }
    }
    
}

extension Apollo: NetworkStatusListener {
    
    func networkStatusDidChange(isEndPointReachable: Bool) {
        if isEndPointReachable {
            connectionState = .ONLINE
        } else {
            connectionState = .OFFLINE
        }
    }
    
}
