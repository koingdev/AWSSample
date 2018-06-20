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
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        example1()
        example2()
    }
    
    @IBAction func onLogin(_ sender: Any) {
        guard let username = txtUsername.text, let password = txtPassword.text else { return }
        CognitoUserPoolManager.sharedInstance.login(username: username, password: password) { error in
            DispatchQueue.main.async {
                if let error = error {
                    UIAlertController.alertOkay(title: "Login failed!", message: error.localizedDescription)
                } else {
                    UIAlertController.alertOkay(title: "Login succeed!", message: "Thank you...") { _ in
                        let sb = UIStoryboard(name: "Main", bundle: nil)
                        let diaryVC = sb.instantiateViewController(withIdentifier: "DiaryVC") as! DiaryVC
                        self.navigationController?.pushViewController(diaryVC, animated: true)
                    }
                }
            }
        }
    }
    
    ////////////////////////////////////////////////////////////////
    //MARK: -
    //MARK: Swift Optimization Testing (Struct vs Class)
    //MARK: -
    ////////////////////////////////////////////////////////////////
    
    class Person {
        let name: String
        let age: Int
        init(name: String, age: Int){
            self.name = name
            self.age = age
        }
    }

    func example1() {
        
        var x = CFAbsoluteTimeGetCurrent()
        
        var array = [Person]()
        
        for _ in 0..<1000 {
            array.append(Person(name: "Foo", age: 30))
        }
        
        // go through the items as well
        for n in 0..<array.count{
            let _ = array[n]
        }
        
        x = CFAbsoluteTimeGetCurrent() - x
        
        print("Class: Took \(x) seconds")
        
    }
    
    
    struct PersonX {
        let name: String
        let age: Int
        init(name: String, age: Int){
            self.name = name
            self.age = age
        }
    }
    
    func example2() {
        
        var x = CFAbsoluteTimeGetCurrent()
        
        var array = [PersonX]()
        
        for _ in 0..<1000 {
            array.append(PersonX(name: "Foo", age: 30))
        }
        
        // go through the items as well
        for n in 0..<array.count{
            let _ = array[n]
        }
        
        x = CFAbsoluteTimeGetCurrent() - x
        
        print("Struct: Took \(x) seconds")

    }
        
}

















