//
//  TrainerListCell.swift
//  fitchike
//
//  Created by Seth Merritt on 7/19/18.
//  Copyright © 2018 leftyseth. All rights reserved.
//

import LBTAComponents


class TrainerListHeader: DatasourceCell {
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "AVAILABLE TRAINERS"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    
    override func setupViews() {
        super.setupViews()
        
        separatorLineView.isHidden = false
        separatorLineView.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        backgroundColor = fitchBlue
        
        addSubview(headerLabel)

        headerLabel.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20)
    }
}

class TrainerListFooter: DatasourceCell {
    
    let footerLabel: UILabel = {
        let label = UILabel()
        label.text = "TEST FOOTER"
        label.textColor = fitchBlue
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = .white
        
        addSubview(footerLabel)
        
        footerLabel.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        
    }
}


class TrainerListCell: DatasourceCell {
    
    override var datasourceItem: Any? {
        didSet {
            //if there is a profile existing
            guard let profile = datasourceItem as? Profile else { return }
            nameLabel.text = profile.name
            quoteLabel.text = profile.quote
            bioTextView.text = profile.bio
            
            if let profileImageURL = profile.profileImageURL {
                self.profileImageview.loadImageUsingCacheWithUrlString(urlString: profileImageURL)
            }
        }
    }
    
    //MARK:- Label constants
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let quoteLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(r: 130, g: 130, b: 130)
        return label
    }()
    
    lazy var bookButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 5
        button.layer.borderColor = fitchBlue.cgColor
        button.layer.borderWidth = 1
        button.setTitle("Schedule", for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 0)
        button.setTitleColor(fitchBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setImage(#imageLiteral(resourceName: "calendar"), for: .normal)
        button.tintColor = fitchBlue
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(notifyOpenTrainerDetail), for: .touchUpInside)
        return button
    }()
    
    let bioTextView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 15)
        tv.backgroundColor = .clear
        return tv
    }()
    
    let profileImageview: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    override func setupViews() {
        
        super.setupViews()
        
        separatorLineView.isHidden = false
        separatorLineView.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        
        backgroundColor = .white
        
        addSubview(nameLabel)
        addSubview(quoteLabel)
        addSubview(bookButton)
        addSubview(bioTextView)
        addSubview(profileImageview)
 
        profileImageview.anchor(topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 60)
        
        nameLabel.anchor(profileImageview.topAnchor, left: profileImageview.rightAnchor, bottom: nil, right: bookButton.leftAnchor, topConstant: 0, leftConstant: 8, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 20)
        
        quoteLabel.anchor(nameLabel.bottomAnchor, left: nameLabel.leftAnchor, bottom: nil, right: nameLabel.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        
        bookButton.anchor(profileImageview.topAnchor, left: nil, bottom: nil, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 8, widthConstant: 120, heightConstant: 34)
        
        bioTextView.anchor(quoteLabel.bottomAnchor, left: nameLabel.leftAnchor, bottom: self.bottomAnchor, right: bookButton.rightAnchor, topConstant: -4, leftConstant: -4, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
    }
    
    //posts a notification that the button has been pushed and will be listened for by the TrainerListDatasource controller
    @objc func notifyOpenTrainerDetail() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notifyOpenTrainerDetail"), object: nil)
    }
    

}

