//
//  ProfileCell.swift
//  fitchike
//
//  Created by Seth Merritt on 7/16/18.
//  Copyright © 2018 leftyseth. All rights reserved.
//

import LBTAComponents

class ProfileCell: DatasourceCell {
    
    override var datasourceItem: Any? {
        didSet {
            guard let profile = datasourceItem as? Profile else { return }
            nameLabel.text = profile.name
            
            if let profileImageURL = profile.profileImageURL {
                self.imageView.loadImageUsingCacheWithUrlString(urlString: profileImageURL)
            }
        }
    }
    
    let nameTitle: UILabel = {
        let title = UILabel()
        title.text = "Name:"
        return title
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = fitchBlue
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(nameTitle)
        
        addSubview(nameLabel)
        addSubview(imageView)
        
        imageView.anchor(topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 60)
        
        nameTitle.anchor(imageView.topAnchor, left: imageView.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 50, heightConstant: 0)
        
        nameLabel.anchor(nameTitle.topAnchor, left: nameTitle.rightAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
    }
}

