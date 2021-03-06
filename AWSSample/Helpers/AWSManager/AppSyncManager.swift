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
    
    private static var appSyncClient: AWSAppSyncClient!
    static var sharedInstance: AWSAppSyncClient? {
        do {
            let tmpUrl = URL(fileURLWithPath: NSTemporaryDirectory())
            let databaseURL = tmpUrl.appendingPathComponent(databasName)
            print(tmpUrl.absoluteString)
            let appSyncConfig = try? AWSAppSyncClientConfiguration(url: endPointURL,
                                                                   serviceRegion: region,
                                                                   userPoolsAuthProvider: CognitoAuthProvider(),
                                                                   databaseURL: databaseURL)
            appSyncClient = try AWSAppSyncClient(appSyncConfig: appSyncConfig!)
            appSyncClient?.apolloClient?.cacheKeyForObject = { $0["id"] }
        } catch {
            print("Error initializing AppSync client. \(error)")
        }
        return appSyncClient
    }
    
    private init() { }
    
}
