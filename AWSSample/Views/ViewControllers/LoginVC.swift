//
//  LoginVC
//  AWSSample
//
//  Created by KoingDev on 6/13/18.
//  Copyright © 2018 KoingDev. All rights reserved.
//

import UIKit

final class LoginVC: UIViewController {

    private let loginViewModel = LoginViewModel()
    @IBOutlet weak var txtUsername: TextFieldX! {
        didSet {
            txtUsername.bind { self.loginViewModel.username = $0  }
        }
    }
    @IBOutlet weak var txtPassword: TextFieldX! {
        didSet {
            txtPassword.bind { self.loginViewModel.password = $0 }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        view.endEditing(true)
    }
    
    @IBAction func onLogin(_ sender: Any) {
        loginViewModel.login(onSuccess: { message in
            UIAlertController.alertOkay(title: "Login succeed!", message: message) { [weak self] _ in
                guard let `self` = self else { return }
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let diaryVC = sb.instantiateViewController(withIdentifier: "DiaryVC") as! DiaryVC
                self.navigationController?.pushViewController(diaryVC, animated: true)
            }
        }, onError: { message in
            UIAlertController.alertOkay(title: "Login failed!", message: message)
        })
    }
    
}

















