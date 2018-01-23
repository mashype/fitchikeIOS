//
//  FirstViewController.swift
//  fitchike
//
//  Created by Seth Merritt on 1/13/18.
//  Copyright © 2018 leftyseth. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ProfilesViewController: UITableViewController {
	
	var db:Firestore!
	
	var profileArray = [Profile]()

	@IBAction func logout(_ sender: Any) {
		handleLogout()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Trainers", style: .plain, target: self, action: #selector(handleViewProfiles))
		db = Firestore.firestore()
		checkIfUserIsLoggedIn()
		
	}

	@objc func handleViewProfiles() {
		let allProfilesViewController = AllProfilesTableViewController()
		let navController = UINavigationController(rootViewController:allProfilesViewController)
		present(navController, animated: true, completion: nil)
	}
	
	func checkIfUserIsLoggedIn() {
		if Auth.auth().currentUser?.uid == nil {
			perform(#selector(handleLogout), with: nil, afterDelay: 0)
			handleLogout()
		} else {
			print("youre logged in")
			checkProfileUpdates()
			loadProfiles()
		}
			
	}

	
	func loadProfiles() {
		db.collection("users").getDocuments { (snapshot, error) in
			if error != nil {
				print(error as Any)
			} else {
				//set the profile array to equal whatever I am querying below
				self.profileArray = snapshot!.documents.flatMap({Profile(dictionary: $0.data())})
				DispatchQueue.main.async {
					self.tableView.reloadData()
				}
			}
		}
	}

	func checkProfileUpdates() {
		print("starting profile updates")
		db.collection("users").whereField("timeStamp", isGreaterThan: Date()).addSnapshotListener { querySnapshot, error in
			guard let snapshot = querySnapshot else {
				print("Error fectching snapshot updates", error)
				return
			}
			snapshot.documentChanges.forEach { diff in
				if (diff.type == .added) {
					print("New add", diff.document.data())
				}
			}
		}
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
	
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return profileArray.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Profile", for: indexPath)
		let profile = profileArray[indexPath.row]
		cell.textLabel?.text = profile.name
		
		return cell
	}


}

