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
        CognitoUserPoolManager.sharedInstance.login(username: username, password: password, completion: completion)
    }
    
}
