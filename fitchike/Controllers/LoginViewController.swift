//
// LoginViewController.swift
//  fitchike
//
//  Created by Seth Merritt on 1/13/18.
//  Copyright © 2018 leftyseth. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore


class LoginViewController: UIViewController {

	var profileArray = [Profile]()
	
	let inputsContainerView: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor.white
		view.translatesAutoresizingMaskIntoConstraints = false
		view.layer.cornerRadius = 5
		view.layer.masksToBounds = true
		return view
	}()
	
	lazy var loginRegisterButton: UIButton = {
		let button = UIButton(type: .system)
		button.backgroundColor = UIColor(r: 193, g: 38, b: 44) //fitchike red
		button.setTitle("Register", for: .normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitleColor(UIColor.white, for: .normal)
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
		
		button.addTarget(self, action: #selector(handleLoginRegister), for: .touchUpInside)
		
		return button
	}()
	
	@objc func handleLoginRegister() {
		if loginRegisterSegmentedControl.selectedSegmentIndex == 0 {
			handleLogin()
		} else {
			handleRegister()
		}
	}
	
	func handleLogin() {
		guard let email = emailTextField.text, let password = passwordTextField.text else { return }
		Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
			if error != nil {
				print(error?.localizedDescription as Any)
				return
			}
			//successfully logged in user
			self.dismiss(animated: true, completion: nil)
		}
	}
	
	
	let nameTextField: UITextField = {
		let tf = UITextField()
		tf.placeholder = "Create Username"
		tf.translatesAutoresizingMaskIntoConstraints = false
		return tf
	}()
	
	let nameSeparatorView: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	let emailTextField: UITextField = {
		let tf = UITextField()
		tf.placeholder = "Email Address"
		tf.translatesAutoresizingMaskIntoConstraints = false
		return tf
	}()
	
	let emailSeparatorView: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	let passwordTextField: UITextField = {
		let tf = UITextField()
		tf.placeholder = "Password"
		tf.translatesAutoresizingMaskIntoConstraints = false
		tf.isSecureTextEntry = true
		return tf
	}()
	
	lazy var profileImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.image = UIImage(named: "sml_logo_only")
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFill

        
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImageView)))
        imageView.isUserInteractionEnabled = true
        
		return imageView
	}()
    
	
	lazy var loginRegisterSegmentedControl: UISegmentedControl = {
		let sc = UISegmentedControl(items: ["Login", "Register"])
		sc.translatesAutoresizingMaskIntoConstraints = false
		sc.tintColor = UIColor.white
		sc.selectedSegmentIndex = 1
		sc.addTarget(self, action: #selector(handleLoginRegisterChange), for: .valueChanged)
		return sc
	}()
	
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
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = UIColor(r: 0, g: 42, b: 69) //dark blue back
		view.addSubview(inputsContainerView)
		view.addSubview(loginRegisterButton)
		view.addSubview(profileImageView)
		view.addSubview(loginRegisterSegmentedControl)
		setupInputsContainerView()
		setupLoginRegisterButton()
		setupProfileImageView()
		setupLoginRegisterSegmentedcontrol()
	}
	
	//function to togglet between login and register
	func setupLoginRegisterSegmentedcontrol() {
		loginRegisterSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		loginRegisterSegmentedControl.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -12).isActive = true
		loginRegisterSegmentedControl.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, multiplier: 1.0).isActive = true
		loginRegisterSegmentedControl.heightAnchor.constraint(equalToConstant: 36).isActive = true
	}
	
	func setupProfileImageView() {
		profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		profileImageView.bottomAnchor.constraint(equalTo: loginRegisterSegmentedControl.topAnchor, constant: -30).isActive = true
		profileImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
		profileImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
	}
	
	var inputsContainerViewHeightAnchor: NSLayoutConstraint?
	var nameTextFieldHeightAnchor: NSLayoutConstraint?
	var emailTextFieldHeightAnchor: NSLayoutConstraint?
	var passwordTextFieldHeightAnchor: NSLayoutConstraint?
	
	func setupInputsContainerView() {
		inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
		inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
		inputsContainerViewHeightAnchor = inputsContainerView.heightAnchor.constraint(equalToConstant: 150)
		inputsContainerViewHeightAnchor?.isActive = true
		
		inputsContainerView.addSubview(nameTextField)
		inputsContainerView.addSubview(nameSeparatorView)
		inputsContainerView.addSubview(emailTextField)
		inputsContainerView.addSubview(emailSeparatorView)
		inputsContainerView.addSubview(passwordTextField)
		
		nameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
		nameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
		nameTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
		nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
		nameTextFieldHeightAnchor?.isActive = true
		
		nameSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
		nameSeparatorView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
		nameSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
		nameSeparatorView.heightAnchor.constraint(equalToConstant: 2).isActive = true
		
		emailTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
		emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
		emailTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
		emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
		emailTextFieldHeightAnchor?.isActive = true
		
		emailSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
		emailSeparatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
		emailSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
		emailSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
		
		passwordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
		passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
		passwordTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
		passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
		passwordTextFieldHeightAnchor?.isActive = true
		
	}
	
	func setupLoginRegisterButton() {
		loginRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		loginRegisterButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 12).isActive = true
		loginRegisterButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
		loginRegisterButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
	}
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}

}

extension UIColor {
	convenience init (r: CGFloat, g: CGFloat, b: CGFloat) {
		self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
	}
}
