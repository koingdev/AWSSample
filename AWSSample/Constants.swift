//
//  Constants.swift
//  AWSSample
//
//  Created by KoingDev on 6/14/18.
//  Copyright © 2018 KoingDev. All rights reserved.
//

import Foundation
import AWSCore

////////////////////////////////////////////////////////////////
//MARK: -
//MARK: AppSync & Cognito CONSTANTS
//MARK: -
////////////////////////////////////////////////////////////////

let region: AWSRegionType = .USEast1
let API_KEY = "???"
let userPoolID = "us-east-1_9XCmAJF4q"
let appClientID = "1r96771echb75omkids99bovs1"
let appClientSecret = "o76k6jgobrlh1an7v9alnqqakicb6jbusik8fm49iq863r21bcm"
let endPointURL = URL(string: "https://qc6lwxun7rdrfat4ajmma2jkq4.appsync-api.us-east-1.amazonaws.com/graphql")!

////////////////////////////////////////////////////////////////
//MARK: -
//MARK: CognitoAuthProvider
//MARK: -
////////////////////////////////////////////////////////////////

final class CognitoAuthProvider {
    static func getLatestAuthToken() -> String {
        return CognitoUserPool.instance
                                     .currentUser?
                                     .getSession()
                                     .result?
                                     .accessToken?
                                     .tokenString ?? ""
    }
}