//
//  LoginModel.swift
//  AWSSample
//
//  Created by KoingDev on 6/21/18.
//  Copyright © 2018 KoingDev. All rights reserved.
//

import Foundation

final class LoginModel {
    
    func login(username: String, password: String, completion: @escaping (Error?) -> Void) {
        let user = CognitoUserPoolManager.sharedInstance.userPool?.getUser(username)
        let task = user?.getSession(username, password: password, validationData: nil)
        task?.continueWith { task in
            // Error
            if let error = task.error {
                completion(error)
                return nil
            }
            // Success
            CognitoUserPoolManager.sharedInstance.author = username
            cognitoToken = task.result?.accessToken?.tokenString ?? ""
            completion(nil)
            return nil
        }
    }
    
}
