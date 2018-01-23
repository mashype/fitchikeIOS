//
//  AllProfilesTableViewController.swift
//  fitchike
//
//  Created by Seth Merritt on 1/15/18.
//  Copyright © 2018 leftyseth. All rights reserved.
//

import UIKit
import FirebaseFirestore

class AllProfilesTableViewController: UITableViewController {
	
	let cellId = "cellId"
	var db : Firestore!
	var profileArray = [Profile]()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))

		tableView.register(ProfileCell.self, forCellReuseIdentifier: cellId)
		
		db = Firestore.firestore()
		fetchUser()
	}
	
	func fetchUser() {
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
	
	@objc func handleCancel() {
		dismiss(animated: true, completion: nil)
	}
	
		
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return profileArray.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
		let profile = profileArray[indexPath.row]
		cell.textLabel?.text = profile.name
		cell.detailTextLabel?.text = profile.email
		return cell
	}

}


class ProfileCell: UITableViewCell {
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
