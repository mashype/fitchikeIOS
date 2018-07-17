//
//  homeViewController+handlers.swift
//  fitchike
//
//  Created by Seth Merritt on 7/16/18.
//  Copyright © 2018 leftyseth. All rights reserved.
//

import UIKit
import Firebase


extension HomeViewController {
    
    @objc func checkIfUserIsLoggedIn() {
        //user is not logged in.
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        }
    }
    
    @objc func handleViewProfiles(sender: UIButton) {
        let controller = TrainerDatasourceController()
        //        present(controller, animated: true, completion: nil)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    

    
}