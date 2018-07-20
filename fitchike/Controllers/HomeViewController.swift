//
//  HomeViewController.swift
//  fitchike
//
//  Created by Seth Merritt on 1/23/18.
//  Copyright © 2018 leftyseth. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class HomeViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
		view.backgroundColor = fitchGray
        
        checkIfUserIsLoggedIn()
		setupViews()
	}
	
	lazy var viewProfilesButton: UIButton = {
		let button = UIButton(type: .system)
		button.backgroundColor = fitchBlue
		button.setTitle("Find Trainers", for: .normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitleColor(UIColor.white, for: .normal)
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
		button.addTarget(self, action: #selector(handleViewProfiles), for: .touchUpInside)
		return button
	}()
    
    lazy var myProfileButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = fitchBlue
        button.setTitle("My Profile", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleViewProfiles), for: .touchUpInside)
        return button
    }()
    
    lazy var workoutHistoryButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = fitchBlue
        button.setTitle("Workout History", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleTrainerDetailTest), for: .touchUpInside)
        return button
    }()
    
    lazy var socialButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = fitchBlue
        button.setTitle("Social Feed", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleViewProfiles), for: .touchUpInside)
        return button
    }()

	lazy var logoutButton: UIButton = {
		let button = UIButton(type: .system)
		button.backgroundColor = fitchRed
		button.setTitle("Logout", for: .normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitleColor(UIColor.white, for: .normal)
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
		button.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
		return button
	}()
	
	//CONSTRAINTS
    
    func setupViews() {
        view.addSubview(viewProfilesButton)
        view.addSubview(myProfileButton)
        view.addSubview(workoutHistoryButton)
        view.addSubview(socialButton)
        view.addSubview(logoutButton)
        
        viewProfilesButton.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 100, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 75)

        myProfileButton.anchor(viewProfilesButton.bottomAnchor, left: viewProfilesButton.leftAnchor, bottom: nil, right: viewProfilesButton.rightAnchor, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 75)
        
        workoutHistoryButton.anchor(myProfileButton.bottomAnchor, left: viewProfilesButton.leftAnchor, bottom: nil, right: viewProfilesButton.rightAnchor, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 75)
        
        socialButton.anchor(workoutHistoryButton.bottomAnchor, left: viewProfilesButton.leftAnchor, bottom: nil, right: viewProfilesButton.rightAnchor, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 75)
        
        logoutButton.anchor(socialButton.bottomAnchor, left: viewProfilesButton.leftAnchor, bottom: nil, right: viewProfilesButton.rightAnchor, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 75)

    }

	
}
