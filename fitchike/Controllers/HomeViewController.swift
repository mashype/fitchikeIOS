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
import Stripe

class HomeViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = fitchGray
        
        checkIfUserIsLoggedIn()
        setupNavbar()
		setupViews()
	}
    
	
	lazy var viewProfilesButton: UIButton = {
		let button = UIButton(type: .system)
		button.backgroundColor = fitchBlue
		button.setTitle("Find Trainers", for: .normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitleColor(UIColor.white, for: .normal)
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
		button.addTarget(self, action: #selector(handleViewTrainers), for: .touchUpInside)
		return button
	}()
    
    lazy var myProfileButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = fitchBlue
        button.setTitle("My Profile", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleViewProfile), for: .touchUpInside)
        return button
    }()
    
    lazy var workoutHistoryButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = fitchBlue
        button.setTitle("Workout History", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        //button.addTarget(self, action: #selector(handleTrainerDetailTest), for: .touchUpInside)
        button.addTarget(self, action: #selector(alamoTest), for: .touchUpInside)
        return button
    }()
    
    lazy var socialButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = fitchBlue
        button.setTitle("STRIPE", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleViewStripe), for: .touchUpInside)
        return button
    }()
    
    lazy var createAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = fitchBlue
        button.setTitle("Create STP Account", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(createStripeCustomer), for: .touchUpInside)
//        button.addTarget(self, action: #selector(handleViewStripe), for: .touchUpInside)
        return button
    }()

	lazy var logoutButton: UIButton = {
		let button = UIButton(type: .system)
		button.backgroundColor = fitchRed
		button.setTitle("Logoutt", for: .normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitleColor(UIColor.white, for: .normal)
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
		button.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
		return button
	}()
	
    private func setupNavbar() {
        let titleImageView = UIImageView(image: #imageLiteral(resourceName: "headerlogo"))
        //set the frame for the icon at the top of the nav bar
        titleImageView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        //force the image into the frame we made above
        titleImageView.contentMode = .scaleAspectFit
        
        navigationItem.titleView = titleImageView
        
        //just removes the shadow line from under the nav bar and replaces it with a lighter line
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        let navBarSeperatorView = UIView()
        navBarSeperatorView.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        view.addSubview(navBarSeperatorView)
        navBarSeperatorView.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0.5)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
    }
    
	//CONSTRAINTS
    
    func setupViews() {
        view.addSubview(viewProfilesButton)
        view.addSubview(myProfileButton)
        view.addSubview(workoutHistoryButton)
        view.addSubview(socialButton)
        view.addSubview(createAccountButton)
        view.addSubview(logoutButton)
        
        viewProfilesButton.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 70, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 75)

        myProfileButton.anchor(viewProfilesButton.bottomAnchor, left: viewProfilesButton.leftAnchor, bottom: nil, right: viewProfilesButton.rightAnchor, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 75)
        
        workoutHistoryButton.anchor(myProfileButton.bottomAnchor, left: viewProfilesButton.leftAnchor, bottom: nil, right: viewProfilesButton.rightAnchor, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 75)
        
        socialButton.anchor(workoutHistoryButton.bottomAnchor, left: viewProfilesButton.leftAnchor, bottom: nil, right: viewProfilesButton.rightAnchor, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 75)
        
        createAccountButton.anchor(logoutButton.bottomAnchor, left: viewProfilesButton.leftAnchor, bottom: nil, right: viewProfilesButton.rightAnchor, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 75)
        
        logoutButton.anchor(socialButton.bottomAnchor, left: viewProfilesButton.leftAnchor, bottom: nil, right: viewProfilesButton.rightAnchor, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 75)

    }

	
}
