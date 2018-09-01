//
//  LoginVC
//  AWSSample
//
//  Created by KoingDev on 6/13/18.
//  Copyright © 2018 KoingDev. All rights reserved.
//

import UIKit

final class LoginVC: UIViewController {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtUsername.text = "koingdev"
        txtPassword.text = "123456"
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        view.endEditing(true)
    }
    
    @IBAction func onLogin(_ sender: Any) {
        guard let username = txtUsername.text, let password = txtPassword.text else { return }
        CognitoUserPool.instance.login(username: username, password: password) { error in
            DispatchQueue.main.async {
                if error == nil {
                    let sb = UIStoryboard(name: "Main", bundle: nil)
                    let vc = sb.instantiateViewController(withIdentifier: "ChoiceVC") as! ChoiceVC
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    UIAlertController.alertOkay(title: "Login failed!", message: error?.localizedDescription ?? "")
                }
            }
        }
    }
    
}

















