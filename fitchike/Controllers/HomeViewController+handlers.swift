//
//  homeViewController+handlers.swift
//  fitchike
//
//  Created by Seth Merritt on 7/16/18.
//  Copyright © 2018 leftyseth. All rights reserved.
//

import UIKit
import Firebase
import Alamofire


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
    
    @objc func alamoTest(sender: UIButton) {
        print(123)
        Alamofire.request("https://jsonplaceholder.typicode.com/posts/1").responseJSON { (response) in
            print("Request :\(String(describing: response.request))")
            print("Response :\(String(describing: response.response))")
            print("Result :\(String(describing: response.result))")

            
            if let json = response.result.value {
                print("JSON: \(json)")
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)")
            }
        }
        
    }
    
    @objc func createStripeCustomer() {
        print("trying to create Stripe Customer")
//        var stripeCustomer = StripeCustomer()
//        let usersReference = db.collection("users").document(currentUser.uid!)
//        guard let email = currentUser.email, let uid = currentUser.uid else { return }
//        let baseURL = URL(string: backendBaseURL)
//        let url = baseURL?.appendingPathComponent("customer")
//
//        let params: [String:Any] = [
//            "description" : uid,
//            "email" : email
//        ]
//
//        Alamofire.request(url!, method: .post, parameters: params).responseJSON { response in
//
//            print("Result: \(response.result)")
//
//            if let json = response.result.value {
//
//                do {
//                    let decoder = JSONDecoder()
//                    stripeCustomer = try decoder.decode(StripeCustomer.self, from: response.data!)
//
//                    usersReference.updateData([
//                        "stripeID": stripeCustomer.id
//                    ]) { err in
//                        if let err = err {
//                            print("Error updating document: \(err)")
//                        } else {
//                            print("Document successfully updated", stripeCustomer.id)
//                        }
//                    }
//
//                } catch let jsonErr {
//                    print("ERROR", jsonErr)
//                }
//
//                print("JSON: \(json)") // serialized json response
//            }
//        }
    }
    

    
}
