//
//  AppSyncManager.swift
//  AWSSample
//
//  Created by KoingDev on 6/14/18.
//  Copyright © 2018 KoingDev. All rights reserved.
//

import Foundation
import AWSAppSync

final class AppSyncManager {
    
    static func instance() -> AWSAppSyncClient {
        let tmpURL = URL(fileURLWithPath: NSTemporaryDirectory())
        let databaseURL = tmpURL.appendingPathComponent(databasName)
        let urlSessionConfiguration = URLSessionConfiguration.default
        // Our custom request header => In resolve mapping: $context.request.headers.author
        urlSessionConfiguration.httpAdditionalHeaders = ["author": CognitoUserPoolManager.instance.author]
        let appSyncConfig = try! AWSAppSyncClientConfiguration(url: endPointURL,
                                                               serviceRegion: region,
                                                               userPoolsAuthProvider: CognitoAuthProvider(),
                                                               urlSessionConfiguration: urlSessionConfiguration,
                                                               databaseURL: databaseURL)
        let appSyncClient = try! AWSAppSyncClient(appSyncConfig: appSyncConfig)
        appSyncClient.apolloClient?.cacheKeyForObject = { $0["id"] }
        return appSyncClient
    }
    
}
