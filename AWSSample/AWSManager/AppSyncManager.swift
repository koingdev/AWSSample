//
//  AppSyncManager.swift
//  AWSSample
//
//  Created by KoingDev on 6/14/18.
//  Copyright © 2018 KoingDev. All rights reserved.
//

import AWSAppSync
import SwiftyJSON

final class AppSyncManager {
    
    private(set) static var urlSessionConfiguration = URLSessionConfiguration.default
    
    static func instance() -> AWSAppSyncClient {
        let tmpURL = URL(fileURLWithPath: NSTemporaryDirectory())
        let databaseURL = tmpURL.appendingPathComponent(databasName)
        // Our custom request header => In resolve mapping: $context.request.headers.author
        urlSessionConfiguration.httpAdditionalHeaders = ["author" : CognitoUserPoolManager.instance.author]
        let appSyncConfig = try! AWSAppSyncClientConfiguration(url: endPointURL,
                                                               serviceRegion: region,
                                                               apiKeyAuthProvider: APIKeyAuthProvider(),
//                                                               userPoolsAuthProvider: CognitoAuthProvider(),
                                                               urlSessionConfiguration: urlSessionConfiguration,
                                                               databaseURL: databaseURL)
        let appSyncClient = try! AWSAppSyncClient(appSyncConfig: appSyncConfig)
        appSyncClient.apolloClient?.cacheKeyForObject = { $0["id"] }
        return appSyncClient
    }
    
    static func setResolver(fileName: String) {
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let resolverMapping = try! JSON(data: data).rawString()!
                                                           .components(separatedBy: .whitespacesAndNewlines)
                                                           .joined()
                                                           .replacingOccurrences(of: "\"", with: "\\\"")
                urlSessionConfiguration.httpAdditionalHeaders = ["resolver" : resolverMapping]
            } catch {
                print("Error...!")
            }
        }
    }
    
}
