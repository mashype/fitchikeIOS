//
//  Booking.swift
//  fitchike
//
//  Created by Seth Merritt on 7/25/18.
//  Copyright © 2018 leftyseth. All rights reserved.
//

import Foundation


struct Booking {
    var trainerID: String?
    var clientID: String?
    var bookingDate: Date?
    var timeStamp: Date?
    
    var dictionary:[String:Any] {
        return [
            "trainerID": trainerID as Any,
            "clientID": clientID as Any,
            "bookingDate": bookingDate as Any,
            "timeStamp": timeStamp as Any
        ]
    }
}


extension Booking : DocumentSerializable {
    init?(dictionary: [String : Any]) {
        guard let trainerID = dictionary["trainerID"] as? String,
        let clientID = dictionary["clientID"] as? String,
        let bookingDate = dictionary["bookingDate"] as? Date,
        let timeStamp = dictionary["timeStamp"] as? Date else { return nil }
        
        self.init(trainerID: trainerID, clientID: clientID, bookingDate: bookingDate, timeStamp: timeStamp)
    }
}


