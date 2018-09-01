//
//  CognitoUserPool.swift
//  AWSSample
//
//  Created by KoingDev on 6/13/18.
//  Copyright © 2018 KoingDev. All rights reserved.
//

import Foundation
import AWSCognitoIdentityProvider

final class CognitoUserPool {

    var userPool: AWSCognitoIdentityUserPool?
    var author: String = ""
    var currentUser: AWSCognitoIdentityUser? {
        get {
            return userPool?.currentUser()
        }
    }

    ////////////////////////////////////////////////////////////////
    //MARK: -
    //MARK: Shared Instance & Init
    //MARK: -
    ////////////////////////////////////////////////////////////////

    static let instance: CognitoUserPool = CognitoUserPool()

    private init() {
        let serviceConfiguration = AWSServiceConfiguration(region: region, credentialsProvider: nil)
        let poolConfiguration = AWSCognitoIdentityUserPoolConfiguration(clientId: appClientID,
                                                                        clientSecret: appClientSecret,
                                                                        poolId: userPoolID)
        AWSCognitoIdentityUserPool.register(with: serviceConfiguration,
                                            userPoolConfiguration: poolConfiguration,
                                            forKey:"AWSSample")
        userPool = AWSCognitoIdentityUserPool(forKey: "AWSSample")
        AWSDDLog.sharedInstance.logLevel = .verbose
    }

    ////////////////////////////////////////////////////////////////
    //MARK: -
    //MARK: Funtionalities
    //MARK: -
    ////////////////////////////////////////////////////////////////

    func login(username: String, password: String, completion: @escaping (Error?) -> Void) {
        author = username
        let user = userPool?.getUser(username)
        let task = user?.getSession(username, password: password, validationData: nil)
        task?.continueWith { task in
            // Error
            if let error = task.error {
                completion(error)
                return nil
            }
            // Success
            completion(nil)
            return nil
        }
    }

    func signup(username: String, password: String, emailAddress: String, completion: @escaping (Error?, AWSCognitoIdentityUser?) -> Void) {
        var attributes = [AWSCognitoIdentityUserAttributeType]()
        let emailAttribute = AWSCognitoIdentityUserAttributeType(name: "email", value: emailAddress)
        attributes.append(emailAttribute)
        let task = userPool?.signUp(username, password: password, userAttributes: attributes, validationData: nil)
        task?.continueWith { task in
            // Error
            if let error = task.error {
                completion(error, nil)
                return nil
            }
            guard let result = task.result else {
                let error = NSError(domain: "KoingDev.AWSSample",
                                    code: 100,
                                    userInfo: ["__type": "Unknown Error", "message": "Cognito user pool error."])
                completion(error, nil)
                return nil
            }
            // Success
            completion(nil, result.user)
            return nil
        }
    }

    func confirmSignup(user: AWSCognitoIdentityUser, confirmationCode: String, completion: @escaping (Error?) -> Void) {
        let task = user.confirmSignUp(confirmationCode)
        task.continueWith { task in
            // Error
            if let error = task.error {
                completion(error)
                return nil
            }
            // Success
            completion(nil)
            return nil
        }
    }

//    func resendConfirmationCode(user: AWSCognitoIdentityUser, completion: @escaping (Error?) -> Void) {
//        let task = user.resendConfirmationCode()
//        task.continueWith { task in
//            if let error = task.error {
//                completion(error)
//                return nil
//            }
//            completion(nil)
//            return nil
//        }
//    }
//
//    func getUserDetails(user: AWSCognitoIdentityUser, completion: @escaping (Error?, AWSCognitoIdentityUserGetDetailsResponse?) -> Void) {
//        let task = user.getDetails()
//        task.continueWith { task in
//            if let error = task.error {
//                completion(error, nil)
//                return nil
//            }
//            guard let result = task.result else {
//                let error = NSError(domain: "KoingDev.AWSSample",
//                                    code: 100,
//                                    userInfo: ["__type": "Unknown Error", "message": "Cognito user pool error."])
//                completion(error, nil)
//                return nil
//            }
//            completion(nil, result)
//            return nil
//        }
//    }

}














