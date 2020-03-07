//
//  ProfileViewController.swift
//  Parstagram
//
//  Created by Yazmin Carrillo on 3/7/20.
//  Copyright © 2020 Yazmin Carrillo. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
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
                    
                    self.usernameLabel.text = fullName
                    self.bioLabel.text = bio
                }
            } else {
                print("Error retrieving profile.")
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
