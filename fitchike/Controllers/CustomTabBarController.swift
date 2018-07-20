//
//  CustomTabBarController.swift
//  fitchike
//
//  Created by Seth Merritt on 7/16/18.
//  Copyright © 2018 leftyseth. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

let db = Firestore.firestore()

let fitchBlue = UIColor(r: 0, g: 113, b: 188)
let fitchRed = UIColor(r: 193, g: 38, b: 44)
let fitchGray = UIColor(r: 232, g: 236, b: 241)



class CustomTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeController = UINavigationController(rootViewController: HomeViewController())
        homeController.tabBarItem.title = "HOME"
        homeController.tabBarItem.image = #imageLiteral(resourceName: "home")
        
        let profileListController = UINavigationController(rootViewController: TrainerListDatasourceController())
        profileListController.tabBarItem.title = "TRAINERS"
        profileListController.tabBarItem.image = #imageLiteral(resourceName: "people")
        
        let profileController = UINavigationController(rootViewController: ProfileController())
        profileController.tabBarItem.title = "ACCOUNT"
        profileController.tabBarItem.image = #imageLiteral(resourceName: "maintenance")
        
        viewControllers = [homeController, profileListController, profileController]
        
    }
    
}

extension UIViewController {

    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
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
    
}




