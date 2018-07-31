//
//  StripeCustomer.swift
//  fitchike
//
//  Created by Seth Merritt on 7/30/18.
//  Copyright © 2018 leftyseth. All rights reserved.
//

import Foundation

struct StripeCustomer: Decodable {
    var id: String?
//    var delinquent: Int?
    var account_balance: Int?
    
//    var dictionary: [String:Any] {
//        return [
//            "id": id as Any,
//            "delinquent": delinquent as Any,
//            "account_balance": account_balance as Any
//        ]
//    }
}


//extension StripeCustomer : DocumentSerializable {
//    init?(dictionary: [String : Any]) {
//        guard let id = dictionary["id"] as? String,
//        let delinquent = dictionary["delinquent"] as? String,
//        let account_balance = dictionary["account_balance"] as? Int else { return nil }
//
//        self.init(id: id, delinquent: delinquent, account_balance: account_balance)
//    }
//}
