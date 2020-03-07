//
//  EditProfileViewController.swift
//  Parstagram
//
//  Created by Yazmin Carrillo on 3/7/20.
//  Copyright © 2020 Yazmin Carrillo. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage
import MessageInputBar

class EditProfileViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var bioTextField: UITextField!
    var user = PFUser.current()!
    var isAuthenticated: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let username = user["username"]
        self.navigationItem.title = username as? String
    
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let fullName = user["fullName"] as? String
        let bio = user["bio"] as? String
        nameTextField.text = fullName
        bioTextField.text = bio
    }
    
    @IBAction func onCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onDoneButton(_ sender: Any) {
        if(user.isAuthenticated) {
            user["fullName"] = nameTextField.text
            user["bio"] = bioTextField.text
            user.saveInBackground { (success, error) in
                if success {
                    print("Profile saved!")
                } else {
                    print("Profile was not saved!")
                }
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onChangeProfilePhoto(_ sender: Any) {
        
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
