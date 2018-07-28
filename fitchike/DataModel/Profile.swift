//
//  User.swift
//  fitchike
//
//  Created by Seth Merritt on 1/15/18.
//  Copyright © 2018 leftyseth. All rights reserved.
//


import Foundation

protocol DocumentSerializable  {
	init?(dictionary:[String:Any])
}

struct Profile {
	var email:String?
	var name:String?
    var quote: String?
    var bio: String?
	var timeStamp:Date?
	var profileImageURL:String?
	
	var dictionary:[String:Any] {
		return [
			"email":email as Any,
			"name":name as Any,
            "quote":quote as Any,
            "bio":bio as Any,
			"timeStamp":timeStamp as Any,
			"profileImageURL":profileImageURL as Any
		]
	}	
}

extension Profile : DocumentSerializable {
	init?(dictionary: [String : Any]) {
		guard let email = dictionary["email"] as? String,
			let name = dictionary["name"] as? String,
            let quote = dictionary["quote"] as? String,
            let bio = dictionary["bio"] as? String,
			let timeStamp = dictionary["timeStamp"] as? Date,
			let profileImageURL = dictionary["profileImageURL"] as? String else {return nil}
		
        self.init(email: email, name: name, quote: quote, bio: bio, timeStamp: timeStamp, profileImageURL: profileImageURL)
	}
}


