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
        } else {
            setCurrentUser()
        }
    }
    
    
    @objc func handleViewTrainers(sender: UIButton) {
        let controller = TrainerListDatasourceController()
        //        present(controller, animated: true, completion: nil)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func handleTrainerDetailTest() {
        let controller = TrainerDetailDatasourceController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func handleViewProfile(sender: UIButton) {
        let controller = ProfileController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func handleViewStripe(sender: UIButton) {
        let controller = BrowseProductsViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    

    
}
