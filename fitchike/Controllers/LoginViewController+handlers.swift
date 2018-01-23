//
//  LoginViewController+handlers.swift
//  fitchike
//
//  Created by Seth Merritt on 1/21/18.
//  Copyright © 2018 leftyseth. All rights reserved.
//

import UIKit
import Firebase


extension LoginViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	
	@objc func handleRegister() {
		guard let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text else { return }
		Auth.auth().createUser(withEmail: email, password: password) { (user: User?, error) in
			if error != nil {
				print(error?.localizedDescription as Any)
				return
			}
			
			guard let uid = user?.uid else { return }
			
			//successfully authenticated user
			let imageName = NSUUID().uuidString //created a uniqueID for the image
			let storageRef = Storage.storage().reference().child("profile_images").child(imageName)  //sets up the reference to the storage bucket
			if let uploadData = UIImagePNGRepresentation(self.profileImageView.image!) {  //turns the profile image loaded to a PNG data to upload.
				storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
					if error != nil {
						print(error as Any)
						return
					}
					
					if let profileImageURL = metadata?.downloadURL()?.absoluteString {
						self.registerUserIntoDatabaseWithUID(uid: uid, name: name, email: email, profileImageURL: profileImageURL)
					}
					
				})
			}
		}
	}
	
	
	private func registerUserIntoDatabaseWithUID(uid: String, name: String, email: String, profileImageURL: String) {
		
		let db = Firestore.firestore()
		let usersReference = db.collection("users")
		let newProfile = Profile(email: email, name: name, timeStamp: Date(), profileImageURL: profileImageURL)

		usersReference.document(uid).setData(newProfile.dictionary, completion: { (usererror) in
			
			if usererror != nil {
				print("USER LOAD ERROR", usererror?.localizedDescription as Any)
				return
			}
			//sucessfully added the user
			self.dismiss(animated: true, completion: nil)
		})
		
	}
	
    
    @objc func handleSelectProfileImageView() {
        let picker = UIImagePickerController()
        picker.delegate = self
		picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		
		var selectedImageFromPicker: UIImage?
		
		if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
			selectedImageFromPicker = editedImage
		} else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
			selectedImageFromPicker = originalImage
		}
		
		if let selectedImage = selectedImageFromPicker {
			profileImageView.image = selectedImage
		}

		dismiss(animated: true, completion: nil)
	}
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("poop")
		dismiss(animated: true, completion: nil)
    }
    
}
