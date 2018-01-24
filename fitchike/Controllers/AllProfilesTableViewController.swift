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
		if let navController = self.navigationController {
			navController.popViewController(animated: true)
		}
	}
	
		
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return profileArray.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ProfileCell
		let profile = profileArray[indexPath.row]
		cell.textLabel?.text = profile.name
		cell.detailTextLabel?.text = profile.email



		if let profileImageURL = profile.profileImageURL {
			cell.profileImageView.loadImageUsingCacheWithUrlString(urlString: profileImageURL)
		}
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 72
	}

}


class ProfileCell: UITableViewCell {
	
	override func layoutSubviews() {
		super.layoutSubviews()
		//customizing the text layouts for a custom cell design
		textLabel?.frame = CGRect(x: 72, y: textLabel!.frame.origin.y - 2, width: textLabel!.frame.width, height: textLabel!.frame.height)
		detailTextLabel?.frame = CGRect(x: 72, y: detailTextLabel!.frame.origin.y + 2, width: detailTextLabel!.frame.width, height: detailTextLabel!.frame.height)
	}
	
	let profileImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.layer.cornerRadius = 28 //1/2 of the size to make it a circle
		imageView.layer.masksToBounds = true
		imageView.contentMode = .scaleAspectFill
		return imageView
	}()
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
		
		addSubview(profileImageView)
		//image constraints
		profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
		profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
		profileImageView.widthAnchor.constraint(equalToConstant: 56).isActive = true
		profileImageView.heightAnchor.constraint(equalToConstant: 56).isActive = true
		
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
