//
//  TrainerDetailCell.swift
//  fitchike
//
//  Created by Seth Merritt on 7/18/18.
//  Copyright © 2018 leftyseth. All rights reserved.
//

import LBTAComponents

//NOT USED RIghT NOW



class TrainerSpecCell: DatasourceCell {
    
    override var datasourceItem: Any? {
        didSet {
            nameLabel.text = datasourceItem as? String
        }
    }
    
    
    let nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "right-arrow")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func setupViews() {
        
        super.setupViews()
        
        addSubview(nameLabel)
        addSubview(iconView)
        
        nameLabel.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        iconView.anchor(topAnchor, left: nil, bottom: nil, right: rightAnchor, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: 10, heightConstant: 10)
        
    }
}


class Section2Cell: DatasourceCell {
    
    override var datasourceItem: Any? {
        didSet {
            //this is where you can update any of your fields in the row based on the datasource.
            //an example of a more complex datasource as an item
            //guard let activity = datasourceItem as? Activity else { return }
            nameLabel.text = datasourceItem as? String
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "TeST"
        return label
    }()
    
    override func setupViews() {
        
        super.setupViews()
        backgroundColor = .orange
        
        addSubview(nameLabel)
        
        nameLabel.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
    }
}
