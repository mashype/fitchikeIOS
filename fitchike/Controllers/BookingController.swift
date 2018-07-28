//
//  BookingController.swift
//  fitchike
//
//  Created by Seth Merritt on 7/25/18.
//  Copyright © 2018 leftyseth. All rights reserved.
//

import LBTAComponents
import Firebase


class BookingController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        nameLabel.text = selectedProfile.email
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTitles()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleCancel))
    }
    
    
    lazy var confirmationButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .red
        button.setTitle("Book", for: .normal)
        button.addTarget(self, action: #selector(confirmBooking), for: .touchUpInside)
        return button
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "logo_wpadding")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let headerTitle: UILabel = {
        let label = UILabel()
        label.text = "LET'S GET THIS THING BOOKED"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameTitle: UILabel = {
        let label = UILabel()
        label.text = "ITS YOU"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    func setupTitles() {
        
        view.addSubview(imageView)
        view.addSubview(headerTitle)
        view.addSubview(nameLabel)
        view.addSubview(nameTitle)
        view.addSubview(confirmationButton)

        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        headerTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        headerTitle.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
        headerTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        headerTitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 10).isActive = true
        
        nameTitle.anchor(headerTitle.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 20)
        
        nameLabel.anchor(nameTitle.bottomAnchor, left: nameTitle.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
        
        confirmationButton.anchor(nameLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 30)
        
    }
    
    @objc func confirmBooking() {
        print("trying to load")
            
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let bookingRef = db.collection("bookings")
        let userRef = db.collection("users").document(uid).collection("bookings")
        
        let newBooking = Booking(trainerID: selectedProfile.email, clientID: uid, bookingDate: Date(), timeStamp: Date())
        
        //adds this new booking to the booking table
        bookingRef.addDocument(data: newBooking.dictionary) { (error) in
            if error != nil {
                print(error as Any)
                return
            } else {
                //once loaded, this section load to the user assocaited table.
                userRef.addDocument(data: newBooking.dictionary) { (error) in
                    if error != nil {
                        print(error as Any)
                        return
                    } else {
                        print("ALL LOADED")
                    }
                }
            }
        }
        
    }
    
}
