//
//  LoginViewController+handlers.swift
//  fitchike
//
//  Created by Seth Merritt on 1/21/18.
//  Copyright © 2018 leftyseth. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase
import Alamofire


extension LoginViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, FBSDKLoginButtonDelegate {
    
    @objc func handleLoginRegister() {
        if loginRegisterSegmentedControl.selectedSegmentIndex == 0 {
            handleLogin()
        } else {
            handleRegister()
        }
    }
    
    //handles the toggle between login and register
    @objc func handleLoginRegisterChange() {
        let title = loginRegisterSegmentedControl.titleForSegment(at: loginRegisterSegmentedControl.selectedSegmentIndex)
        loginRegisterButton.setTitle(title, for: .normal)
        //if the index is 0 (i.e. login) set the height to 100, otherwise it is 150
        inputsContainerViewHeightAnchor?.constant = loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 100 : 150
        nameTextFieldHeightAnchor?.isActive = false
        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 0 : 1/3)
        nameTextFieldHeightAnchor?.isActive = true
        
        emailTextFieldHeightAnchor?.isActive = false
        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        emailTextFieldHeightAnchor?.isActive = true
        
        passwordTextFieldHeightAnchor?.isActive = false
        passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        passwordTextFieldHeightAnchor?.isActive = true
    }
    
    func handleLogin() {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                print(error?.localizedDescription as Any)
                return
            }
            //successfully logged in user
            self.setCurrentUser()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
	@objc func handleRegister() {
        //need to fix the load of the quote and the bio field.
        var bio = "TEST"
        var quote = "TEST"
        
		guard let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text else { return }
		Auth.auth().createUser(withEmail: email, password: password) { (user: User?, error) in
			if error != nil {
				print(error?.localizedDescription as Any)
				return
			}
			
			guard let uid = user?.uid else { return }

			let imageName = NSUUID().uuidString //created a uniqueID for the image
			let storageRef = Storage.storage().reference().child("profile_images").child(imageName)  //sets up the reference to the storage bucket
			if let uploadData = UIImagePNGRepresentation(self.profileImageView.image!) {  //turns the profile image loaded to a PNG data to upload.
				storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
					if error != nil {
						print(error as Any)
						return
					}
					if let profileImageURL = metadata?.downloadURL()?.absoluteString {
                        self.registerUserIntoDatabaseWithUID(uid: uid, name: name, email: email, bio: bio, quote: quote, profileImageURL: profileImageURL)
					}
                    
				})
			}
		}
	}
    
    
    //MARK:-  FACEBOOK LOGON FUNCTIONS
    
    @objc func handleCustomFBLogin() {
        FBSDKLoginManager().logIn(withReadPermissions: ["email", "public_profile"], from: self) { (result, err) in
            if err != nil {
                print("FB Logn Failed:", err as Any)
                return
            }
            self.showEmailAddress()
        }
    }
    
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did Log Out")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            //this means we had a problem logging in
            print("error logging in \(error)")
        }

        showEmailAddress()

    }
    
    func showEmailAddress() {
        //gets the current FB access token and creates the user into the file
        let accessToken = FBSDKAccessToken.current()
        guard let accessTokenString = accessToken?.tokenString else { return }
        
        let credentials = FacebookAuthProvider.credential(withAccessToken: accessTokenString)
        
        Auth.auth().signInAndRetrieveData(with: credentials) { (user, error) in
            if error != nil {
                print("Something wrong with the FB login", error as Any)
                return
            }
            //successfully logged in user
            self.setCurrentUser()
            self.updateUserProfile()
            self.dismiss(animated: true, completion: nil)
            print("Successfully logged in with user", user as Any)
        }
        
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"]).start { (connection, result, err) in
            if err != nil {
                print("Failed to start graph request:", err as Any)
                return
            }
            print("Here is your user data:", result as Any)
        }
    }
    
    //Creating a function to create/update a profile/user record from FB account.
    @objc func updateUserProfile() {
        
        //need to fix the load of the quote and the bio field.
        var bio = "filler"
        var quote = "FILLER"
        
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                guard let uid = user?.uid, let name = user?.displayName, let email = user?.email, let profileImageURL = user?.photoURL?.absoluteString else { return }
                self.registerUserIntoDatabaseWithUID(uid: uid, name: name, email: email, bio: bio, quote: quote, profileImageURL: profileImageURL)
            }
        }
    }
	
    //MARK:- Image Selection Functions
    
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
    
    private func registerUserIntoDatabaseWithUID(uid: String, name: String, email: String, bio: String, quote: String, profileImageURL: String) {
        
        let usersReference = db.collection("users")
        let newProfile = Profile(uid: uid, email: email, name: name, quote: quote, bio: bio, timeStamp: Date(), profileImageURL: profileImageURL)
        
        usersReference.document(uid).setData(newProfile.dictionary, completion: { (usererror) in
            
            if usererror != nil {
                print("USER LOAD ERROR", usererror?.localizedDescription as Any)
                return
            }
            //sucessfully added the user
            self.createStripeCustomer(uid: uid, email: email)
            self.setCurrentUser()
            self.dismiss(animated: true, completion: nil)
        })
        
    }
    
    
    private func createStripeCustomer(uid: String, email: String) {
        
        var stripeCustomer = StripeCustomer()
        let usersReference = db.collection("users").document(uid)
        let baseURL = URL(string: backendBaseURL)
        let url = baseURL?.appendingPathComponent("customer")
        let params: [String:Any] = [
            "description" : uid,
            "email" : email
        ]
        
        print("trying to create Stripe Customer")
        Alamofire.request(url!, method: .post, parameters: params).responseJSON { response in
            //print("Result: \(response.result)")
            if let json = response.result.value {
                do {
                    let decoder = JSONDecoder()
                    stripeCustomer = try decoder.decode(StripeCustomer.self, from: response.data!)
                    usersReference.updateData([
                        "stripeID": stripeCustomer.id as Any
                    ]) { err in
                        if let err = err {
                            print("Error updating document: \(err)")
                        } else {
                            print("Document successfully updated", stripeCustomer.id as Any)
                        }
                    }
                } catch let jsonErr {
                    print("ERROR", jsonErr)
                }
                //once loaded to Firebase and Stripe we set the current user.
                self.setCurrentUser()
                print("JSON: \(json)") // serialized json response
            }
        }
    }
    
    
    
}
