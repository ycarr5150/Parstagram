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
    var user = PFUser.current()
    var profile = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let username = user!["username"]
        self.navigationItem.title = username as? String
    
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let query = PFQuery(className: "Profile")
        
        query.whereKey("username", equalTo: user!)
        query.findObjectsInBackground { (profile, error) in
            if profile != nil {
                self.profile = profile!
                
                for pro in profile! {
                    let fullName = pro["name"] as? String
                    let bio = pro["bio"] as? String
                    
                    self.nameTextField.text = fullName
                    self.bioTextField.text = bio
                }
            } else {
                print("Error retrieving profile.")
            }
        }
        /*
         query.getObjectInBackground(withId: "xWMyZEGZ") { (gameScore: PFObject?, error: Error?) in
             if let error = error {
                 print(error.localizedDescription)
             } else if let gameScore = gameScore {
                 gameScore["cheatMode"] = true
                 gameScore["score"] = 1338
                 gameScore.saveInBackground()
             }
         }
         */
    }
    

    
    @IBAction func onCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)

    }
    
    @IBAction func onDoneButton(_ sender: Any) {
        let editedUser = PFObject(className: "Profile")
        
        editedUser["username"] = PFUser.current()
        editedUser["name"] = nameTextField.text!
        editedUser["bio"] = bioTextField.text!
        
        editedUser.saveInBackground { (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
                print("Saved profile!")
            } else {
                print("Error saving profile")
            }
        }
        /*
         let imageData = uploadImageView.image!.pngData()
         let file = PFFileObject(name: "image.png", data: imageData!)
         
         post["image"] = file
         */

        dismiss(animated: true, completion: nil)
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
