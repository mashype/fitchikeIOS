//
//  HomeViewController.swift
//  fitchike
//
//  Created by Seth Merritt on 1/23/18.
//  Copyright © 2018 leftyseth. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
		
		view.backgroundColor = UIColor(r: 61, g: 91, b: 151)
		view.addSubview(viewProfilesButton)
		view.addSubview(logoutButton)
		
		setupViewProfilesButton()
		setupLogoutButton()
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
	
	lazy var viewProfilesButton: UIButton = {
		let button = UIButton(type: .system)
		button.backgroundColor = UIColor(r: 0, g: 113, b: 188) //fitchike blue
		button.setTitle("Find Trainers", for: .normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitleColor(UIColor.white, for: .normal)
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
		
		button.addTarget(self, action: #selector(handleViewProfiles), for: .touchUpInside)
		
		return button
	}()

	lazy var logoutButton: UIButton = {
		let button = UIButton(type: .system)
		button.backgroundColor = UIColor(r: 193, g: 38, b: 44) //fitchike red
		button.setTitle("Logout", for: .normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitleColor(UIColor.white, for: .normal)
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
		
		button.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
		
		return button
	}()
	
	@objc func handleViewProfiles(sender: UIButton) {
		let controller = AllProfilesTableViewController()
//		present(controller, animated: true, completion: nil)
		self.navigationController?.pushViewController(controller, animated: true)
	}
	
	
	//CONSTRAINTS
	func setupViewProfilesButton() {
		viewProfilesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		viewProfilesButton.topAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
		viewProfilesButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20).isActive = true
		viewProfilesButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
	}
	
	func setupLogoutButton() {
		logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		logoutButton.topAnchor.constraint(equalTo: viewProfilesButton.bottomAnchor, constant: 25).isActive = true
		logoutButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20).isActive = true
		logoutButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
	}
	
}
