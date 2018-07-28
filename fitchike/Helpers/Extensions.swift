//
//  Extensions.swift
//  fitchike
//
//  Created by Seth Merritt on 1/23/18.
//  Copyright © 2018 leftyseth. All rights reserved.
//

import UIKit
import Firebase

let imageCache = NSCache<AnyObject, AnyObject>() //cache to hold all our downloaded images.

extension UIImageView {
	
	func loadImageUsingCacheWithUrlString(urlString: String) {
		
		//just blanks out the image before we download them as rows scroll
		self.image = nil
		
		//check cache for image first.
		if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage { //this is the url that we passed from the profile. if exists, then dont download
			self.image = cachedImage //in this case the image will be the cached image
			return
		}
		
		let url = URL(string: urlString)
		URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
			//there was a download error
			if error != nil {
				print(error?.localizedDescription as Any)
				return
			}
			//dl successful. pulling the data from the download to an image file.
			DispatchQueue.main.async {
				//setting a new downloaded image function with the cached images.
				if let downloadedImage = UIImage(data: data!) {
					imageCache.setObject(downloadedImage, forKey: urlString as AnyObject) //sets the image
					self.image = downloadedImage
				}
			}
			
		}).resume() //resume is reuired to actually fire off the URL session request.
	}
	
}



extension UIViewController {
    
    @objc func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleLogout() {
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        let loginController = LoginViewController()
        present(loginController, animated: true, completion: nil)
    }
    
    //updates the current user to stay current on the current logged in user as a Profile object.
    func setCurrentUser() {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("no current user")
            return
        }
        
        let userRef = db.collection("users").document(uid)
        userRef.getDocument { (document, error) in
            if error != nil {
                print(error as Any)
            } else {
                currentUser = Profile(dictionary: (document?.data())!)!
            }
        }
    }
    
}

