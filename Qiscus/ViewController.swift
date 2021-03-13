//
//  ViewController.swift
//  Qiscus
//
//  Created by hilmy ghozy on 13/03/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    
    let usernameA = ["hilmy","ghozy"]
    let passwordA = "1234"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func submitBtn(_ sender: Any) {
        let username = usernameTF.text!
        let password = passwordTF.text!
        
        if usernameA.contains(username){
            if password == passwordA{
                print("Success")
                
            }
        }
        else if usernameA.contains(username) == false, password != passwordA {
            let alert = UIAlertController(title: "Login failed", message: "Wrong username / password", preferredStyle: UIAlertController.Style.alert)
             alert.addAction(UIAlertAction(title: "Try again", style: UIAlertAction.Style.default, handler: nil))
             self.present(alert, animated: true, completion: nil)
        }
        
        else {
            let alert = UIAlertController(title: "Login failed", message: "Wrong username / password", preferredStyle: UIAlertController.Style.alert)
             alert.addAction(UIAlertAction(title: "Try again", style: UIAlertAction.Style.default, handler: nil))
             self.present(alert, animated: true, completion: nil)
            
        }
            
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginSuccess" {
            let vc = segue.destination as! ChatViewController
            vc.user = usernameTF.text!
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        guard let username = usernameTF.text, !usernameTF.text!.isEmpty, usernameA.contains(username) else {
            print("username invalid")
            
            return false
        }
        guard let password = passwordTF.text, !passwordTF.text!.isEmpty, password == passwordA else {
            print("password invalid")
            return false
        }
        return true
    }
    

}

