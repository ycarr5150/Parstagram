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

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    var user = PFUser.current()!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let username = user["username"]
        
        self.navigationItem.title = username as? String
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let fullName = user["fullName"] as? String
        let bio = user["bio"] as? String
        let imageFile = user["profilePic"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        usernameLabel.text = fullName
        bioLabel.text = bio
        profileImage.af_setImage(withURL: url)
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
