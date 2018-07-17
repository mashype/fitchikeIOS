//
//  TrainerDetailController.swift
//  fitchike
//
//  Created by Seth Merritt on 7/16/18.
//  Copyright © 2018 leftyseth. All rights reserved.
//

import LBTAComponents

class TrainerDetailController: UIViewController {
    
    var profile: Profile? {
        didSet {
            navigationItem.title = "Trainer Detail"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupTitles()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleCancel))
        
    }
    
    func setupTitles() {
        let nameTitle: UILabel = {
            let label = UILabel()
            label.text = "TRNZ"
            label.font = UIFont.boldSystemFont(ofSize: 20)
            return label
        }()
        
        
        let nameLabel: UITextView = {
            let label = UITextView()
            label.text = profile?.name
            label.font = UIFont.systemFont(ofSize: 16)
            return label
        }()
        
        view.addSubview(nameLabel)
        view.addSubview(nameTitle)
    
        nameTitle.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 100, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 20)
        
        nameLabel.anchor(nameTitle.bottomAnchor, left: nameTitle.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
       
    }
}
