//
//  TrainerListDatasourceController+navbar.swift
//  fitchike
//
//  Created by Seth Merritt on 7/21/18.
//  Copyright © 2018 leftyseth. All rights reserved.
//

import UIKit

extension TrainerListDatasourceController {
    
    func setupNavigationBarItems() {
        setupRightNavItems()
        //comment this out until I clean up the functions to have the back button
        //setupLeftNavItem()
        setupRemainingNavItems()
    }
    
    private func setupRightNavItems() {
        let searchButton = UIButton(type: .system)
        searchButton.setImage(#imageLiteral(resourceName: "search"), for: .normal)
        searchButton.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        searchButton.contentMode = .scaleAspectFit
        
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
        
        let accountButton = UIButton(type: .system)
        accountButton.setImage(#imageLiteral(resourceName: "maintenance"), for: .normal)
        accountButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        
        //an array of right bar button items lets you put multiple over there.
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: accountButton), UIBarButtonItem(customView: searchButton)]
    }
    
    private func setupLeftNavItem() {
        let homeButton = UIButton(type: .system)
        homeButton.setImage(#imageLiteral(resourceName: "home"), for: .normal)
        homeButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)

        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: homeButton)
    }
    
    private func setupRemainingNavItems() {
        let titleImageView = UIImageView(image: #imageLiteral(resourceName: "headerlogo"))
        //set the frame for the icon at the top of the nav bar
        titleImageView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        //force the image into the frame we made above
        titleImageView.contentMode = .scaleAspectFit
        
        navigationItem.titleView = titleImageView
        
        //just removes the shadow line from under the nav bar and replaces it with a lighter line
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        let navBarSeperatorView = UIView()
        navBarSeperatorView.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        view.addSubview(navBarSeperatorView)
        navBarSeperatorView.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0.5)
    }
    
}
