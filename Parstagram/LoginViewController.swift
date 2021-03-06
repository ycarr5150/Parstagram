//
//  LoginViewController.swift
//  Parstagram
//
//  Created by Yazmin Carrillo on 3/3/20.
//  Copyright © 2020 Yazmin Carrillo. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController, UIImagePickerControllerDelegate {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSignIn(_ sender: Any) {
        let username = usernameField.text!
        let password = passwordField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if user != nil {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                print("Error: \(error!.localizedDescription)")
            }
        }
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        let user = PFUser()

        user.username = usernameField.text
        user.password = passwordField.text
        user["fullName"] = "John Doe"
        user["bio"] = "Hello! I am new to this app! Pleased to meet you."
        
        let image = UIImage(named: "profile_tab.png")
        let imageData = image?.pngData()
        let file = PFFileObject(name: "profile.png", data: imageData!)
        user["profilePic"] = file
        
        user.signUpInBackground { (success, error) in
            if success {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                print("Error: \(error!.localizedDescription)")
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
