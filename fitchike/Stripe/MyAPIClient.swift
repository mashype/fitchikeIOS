//
//  BackendAPIAdapter.swift
//  Standard Integration (Swift)
//
//  Created by Ben Guo on 4/15/16.
//  Copyright © 2016 Stripe. All rights reserved.
//

import Foundation
import Stripe
import Alamofire

class MyAPIClient: NSObject, STPEphemeralKeyProvider {

    static let sharedClient = MyAPIClient()
    var baseURLString: String? = nil
    var baseURL: URL {
        if let urlString = self.baseURLString, let url = URL(string: urlString) {
            return url
        } else {
            fatalError()
        }
    }
    
//    func createStripeCustomer(_ email: String, completion: @escaping STPErrorBlock) {
//        let url = self.baseURL.appendingPathComponent("customers")
//
//        var params: [String:Any] = [
//            "email": currentUser.email as Any
//        ]
//
//        Alamofire.request(url, method: .post, parameters: params).validate(statusCode: 200..<300).responseString { (response) in
//            switch response.result {
//            case .success:
//                completion(nil)
//            case .failure(let error):
//                completion(error)
//            }
//        }
//    }
    

    func completeCharge(_ result: STPPaymentResult,
                        amount: Int,
                        shippingAddress: STPAddress?,
                        shippingMethod: PKShippingMethod?,
                        completion: @escaping STPErrorBlock) {
        let url = self.baseURL.appendingPathComponent("charge")
        
        //these are the params that we are sending to the index.js file on Heroku
        var params: [String: Any] = [
            //we could pass the source, but requires a token and easier to just pass over the Strip CustomerID
            "source": result.source.stripeID,
            "customer": "cus_DJIU8Qei8XtI6Y",
            "amount": amount,
            "currency": "USD"
            
        ]
        params["shipping"] = STPAddress.shippingInfoForCharge(with: shippingAddress, shippingMethod: shippingMethod)
        Alamofire.request(url, method: .post, parameters: params)
            .validate(statusCode: 200..<300)
            .responseString { response in
                switch response.result {
                case .success:
                    completion(nil)
                case .failure(let error):
                    completion(error)
                }
        }
    }
    
    
    

    func createCustomerKey(withAPIVersion apiVersion: String, completion: @escaping STPJSONResponseCompletionBlock) {
        let url = self.baseURL.appendingPathComponent("ephemeral_keys")
        Alamofire.request(url, method: .post, parameters: [
            "api_version": apiVersion,
            //this is what we post up to stripe/heroku and should be the variable from the real customerID

            "customer_id": "cus_DJIU8Qei8XtI6Y"
            ])
            .validate(statusCode: 200..<300)
            .responseJSON { responseJSON in
                switch responseJSON.result {
                case .success(let json):
                    completion(json as? [String: AnyObject], nil)
                case .failure(let error):
                    completion(nil, error)
                }
        }
    }

}
