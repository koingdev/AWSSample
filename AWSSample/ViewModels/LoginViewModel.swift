//
//  LoginViewModel.swift
//  AWSSample
//
//  Created by KoingDev on 6/21/18.
//  Copyright © 2018 KoingDev. All rights reserved.
//

import Foundation

final class LoginViewModel {
    
    let loginModel = LoginModel()
    var username: String!
    var password: String!
    
    func login(onSuccess: @escaping (String) -> Void, onError: @escaping (String) -> Void) {
        loginModel.login(username: username, password: password) { error in
            DispatchQueue.main.async {
                if error == nil {
                    onSuccess("Thank you...!")
                } else {
                    onError(error?.localizedDescription ?? "")
                }
            }
        }
    }
    
}
