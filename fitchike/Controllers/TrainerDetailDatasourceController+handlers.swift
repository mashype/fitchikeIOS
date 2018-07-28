//
//  TrainerDetailDatasourceController+handlers.swift
//  fitchike
//
//  Created by Seth Merritt on 7/25/18.
//  Copyright © 2018 leftyseth. All rights reserved.
//

import LBTAComponents

extension TrainerDetailDatasourceController {
    
    func setupNavigationItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.title = selectedProfile.name
        
        NotificationCenter.default.addObserver(self, selector: #selector(createBooking(not:)), name: NSNotification.Name(rawValue: "notifyOpenBooking"), object: nil)
    }
    
    func showCertifications() {
        let certController = HomeViewController()
        let navController = UINavigationController(rootViewController: certController)
        present(navController, animated: true, completion: nil)
    }
    
    
    @objc func createBooking(not: Notification) {
        let bookingController = BookingController()
        let navController = UINavigationController(rootViewController: bookingController)
        present(navController, animated: true, completion: nil)
        
        //NO REAL NEED FOR THIS buT juSt thOWIng HOW TO PASs DATA WITH NOTIFICATION
        if let testObject = not.userInfo {
            if let userName = testObject["name"] as? String {
                print(userName)
            }
        }
        print("CurrentUser", currentUser.email as Any)
        print("selected trainer", selectedProfile.email as Any)
    }

    
}
