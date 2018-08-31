//
//  Apollo.swift
//  AWSSample
//
//  Created by KoingDev on 6/14/18.
//  Copyright © 2018 KoingDev. All rights reserved.
//

import Apollo

final class Apollo {
    
    static let instance = Apollo()
    var client: ApolloClient {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Content-Type" : "application/json"]
        configuration.httpAdditionalHeaders = ["User-Agent" : "aws-sdk-ios/2.6.18 AppSyncClient"]
        //        configuration.httpAdditionalHeaders = ["x-api-key" : API_KEY]
        configuration.httpAdditionalHeaders = ["authorization" : CognitoAuthProvider.getLatestAuthToken()]
        let networkTransport = HTTPNetworkTransport(url: endPointURL, configuration: configuration)
        let apollo = ApolloClient(networkTransport: networkTransport)
        return apollo
    }
    
}
