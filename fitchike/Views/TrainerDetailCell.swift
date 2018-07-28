//
//  TestCell.swift
//  fitchike
//
//  Created by Seth Merritt on 7/21/18.
//  Copyright © 2018 leftyseth. All rights reserved.
//

import LBTAComponents


class TrainerDetailHeader: DatasourceCell {
    
    let detailLabel: UILabel = {
        let label = UILabel()
        label.text = "TRAINER DETAIL"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = fitchRed
        
        addSubview(detailLabel)
        
        detailLabel.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
}

class TrainerDetailFooter: DatasourceCell {
    override func setupViews() {
        super.setupViews()
        backgroundColor = .green
    }
}

class TrainerDetailCell: DatasourceCell {

    //what to update when the datasource item gets setup
    override var datasourceItem: Any? {
        didSet {
            //if there is a profile existing
            guard let profile = datasourceItem as? Profile else { return }
            quoteLabel.text = profile.quote
            bioLabel.text = profile.bio
            
            if let profileImageURL = profile.profileImageURL {
                self.profileImageview.loadImageUsingCacheWithUrlString(urlString: profileImageURL)
            }
        }
    }
    
    lazy var bookButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = fitchBlue
        button.setTitle("SCHEDULE NOW", for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(notifyBookingRequest), for: .touchUpInside)
        return button
    }()
    
    let quoteTitle: UILabel = {
        let label = UILabel()
        label.text = "My Quote"
        label.textColor = fitchBlue
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    
    let quoteLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let bioTitle: UILabel = {
        let label = UILabel()
        label.text = "My Bio"
        label.textColor = fitchBlue
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    
    let bioLabel: UITextView = {
        let label = UITextView()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let profileImageview: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 5
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        return imageView
    }()
    

    @objc func notifyBookingRequest() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notifyOpenBooking"), object: self, userInfo: ["name" : "SethiePoo"])
    }

    override func setupViews() {
        
        let approximateWidthofBioTextView = frame.width - 100 - 10 - 10 - 10
        let size = CGSize(width: approximateWidthofBioTextView, height: 1000)
        let attributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]
        let estimatedFrame = NSString(string: selectedProfile.bio!).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        
        super.setupViews()
        
        addSubview(quoteTitle)
        addSubview(quoteLabel)
        addSubview(bioTitle)
        addSubview(bioLabel)
        addSubview(profileImageview)
        addSubview(bookButton)
        
        profileImageview.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        profileImageview.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        profileImageview.widthAnchor.constraint(equalToConstant: 100).isActive = true
        profileImageview.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        quoteTitle.anchor(profileImageview.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 100, heightConstant: 20)
        
        quoteLabel.anchor(quoteTitle.topAnchor, left: quoteTitle.rightAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 20)
        
        bioTitle.anchor(quoteTitle.bottomAnchor, left: quoteTitle.leftAnchor, bottom: nil, right: quoteTitle.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        
        bioLabel.anchor(bioTitle.topAnchor, left: quoteLabel.leftAnchor, bottom: nil, right: quoteLabel.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: estimatedFrame.height + 20)
        
        bookButton.anchor(bioLabel.bottomAnchor, left: bioLabel.leftAnchor, bottom: nil, right: bioLabel.rightAnchor, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
        
    }
        
}
