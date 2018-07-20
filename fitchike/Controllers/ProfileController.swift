//
//  ProfileController.swift
//  fitchike
//
//  Created by Seth Merritt on 7/17/18.
//  Copyright © 2018 leftyseth. All rights reserved.
//
//  View and edit the curret user profile

import LBTAComponents
import Firebase

class ProfileController: UIViewController {

    var profile = Profile()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchUser()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupTitles()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleCancel))
    }
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let userRef = db.collection("users").document(uid)
        userRef.getDocument { (document, error) in
            if error != nil {
                print(error as Any)
            } else {
                self.profile = Profile(dictionary: (document?.data())!)!
                DispatchQueue.main.async {
                    self.setupTitles()
                    print("Heres the profile", self.profile)
                }
                self.navigationItem.title = self.profile.name
                
            }
        }
    }
    
    
    func setupTitles() {
        
        let imageView: UIImageView = {
            let imageView = UIImageView()
            
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFill
            return imageView
        }()
        
        let nameTitle: UILabel = {
            let label = UILabel()
            label.text = "ITS YOU"
            label.font = UIFont.boldSystemFont(ofSize: 20)
            return label
        }()
        
        
        let nameLabel: UITextView = {
            let label = UITextView()
            label.text = profile.name
            label.font = UIFont.systemFont(ofSize: 16)
            return label
        }()
        
        
        
        view.addSubview(imageView)
        view.addSubview(nameLabel)
        view.addSubview(nameTitle)
        
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        nameTitle.anchor(imageView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 100, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 20)
        
        nameLabel.anchor(nameTitle.bottomAnchor, left: nameTitle.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
        
    }
    
}
