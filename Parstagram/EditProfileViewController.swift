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

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var bioTextField: UITextField!
    @IBOutlet weak var uploadImageView: UIImageView!
    
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
        let imageFile = user["profilePic"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        nameTextField.text = fullName
        bioTextField.text = bio
        uploadImageView.af_setImage(withURL: url)
    }
    
    @IBAction func onCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onDoneButton(_ sender: Any) {
        if(user.isAuthenticated) {
            user["fullName"] = nameTextField.text
            user["bio"] = bioTextField.text
            
            let imageData = uploadImageView.image!.pngData()
            let file = PFFileObject(name: "profile.png", data: imageData!)
            user["profilePic"] = file
            
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
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 25, height: 25)
        let scaledImage = image.af_imageAspectScaled(toFill: size)
        
        uploadImageView.image = scaledImage
        
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
