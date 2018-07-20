//
//  TrainerDetailCell.swift
//  fitchike
//
//  Created by Seth Merritt on 7/18/18.
//  Copyright © 2018 leftyseth. All rights reserved.
//

import LBTAComponents




class TrainerDetailHeader: DatasourceCell {
    override func setupViews() {
        super.setupViews()
        backgroundColor = .blue
    }
}

class TrainerDetailFooter: DatasourceCell {
    override func setupViews() {
        super.setupViews()
        backgroundColor = .green
    }
}


class ElementCell: DatasourceCell {
    
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
        backgroundColor = .yellow
        
        addSubview(nameLabel)
        
        nameLabel.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
    }
}


class TestCell: DatasourceCell {
    
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
