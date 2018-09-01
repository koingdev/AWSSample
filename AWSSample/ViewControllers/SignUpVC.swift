//
//  SignUpVC.swift
//  AWSSample
//
//  Created by KoingDev on 6/13/18.
//  Copyright © 2018 KoingDev. All rights reserved.
//

import UIKit
import AWSCognitoIdentityProvider

final class SignUpVC: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtUsername: UITextField!

    @IBAction func onCreateAccount(_ sender: Any) {
        guard let username = txtUsername.text, let password = txtPassword.text, let emailAddress = txtEmail.text else { return }
        CognitoUserPool.instance.signup(username: username, password: password, emailAddress: emailAddress) { error, user in
            DispatchQueue.main.async { [unowned self] in
                if let error = error {
                    UIAlertController.alertOkay(title: "Sign up failed!", message: error.localizedDescription)
                    return
                }
                guard let user = user else {
                    UIAlertController.alertOkay(title: "Sign up failed!", message: "Missing user data...")
                    return
                }
                if user.confirmedStatus != AWSCognitoIdentityUserStatus.confirmed {
                    self.requestConfirmCode(user)
                } else {
                    self.alertSuccess()
                }
            }
        }
    }
    
    fileprivate func requestConfirmCode(_ user: AWSCognitoIdentityUser) {
        UIAlertController.alertTextField(title: "Confirmation", message: "Type the 6-digit code that has been sent to your email.") { texts in
            let confirmationCode = texts[0]
            CognitoUserPool.instance.confirmSignup(user: user, confirmationCode: confirmationCode) { error in
                DispatchQueue.main.async { [weak self] in
                    guard let `self` = self else { return }
                    if let error = error {
                        UIAlertController.alertOkay(title: "Invalid code!", message: error.localizedDescription) { [weak self] _ in
                            guard let `self` = self else { return }
                            self.requestConfirmCode(user)
                        }
                    } else {
                        self.alertSuccess()
                    }
                }
            }
        }
    }
    
    fileprivate func alertSuccess() {
        UIAlertController.alertOkay(title: "Sign up succeed!", message: "Your account has been created...") { [weak self] _ in
            guard let `self` = self else { return }
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}
















