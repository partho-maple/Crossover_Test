//
//  JitenshaAPI.swift
//  Rent-A-Bike
//
//  Created by Partho Biswas on 5/27/16.
//  Copyright © 2016 Partho Biswas. All rights reserved.
//

import Siesta
import SwiftyJSON
import CoreLocation


private let kPrivateEncoderDecoderKey: String = "sHJBghGvHGJvJhgvGhv786578767tJHHJVhyytfJHGVUVu78tUYVUYYF&vuytf7v"
private let baseURL : String = "http://localhost:8080/"
let JitenshaAPI = _JitenshaAPI()

class _JitenshaAPI {
    
    private var accessToken : String?
    let service = Service(baseURL: baseURL)
    var signinDelegate: JitenshaAPISigninDelegate?
    var signupDelegate: JitenshaAPISignupDelegate?
    var fetchPlaceDelegate: JitenshaAPIFetchDelegate?
    var paymentDelegate: JitenshaAPIPaymentDelegate?
    
    private init() {
        
        Siesta.enabledLogCategories = LogCategory.all
        debugPrint(Utils.getUserDefault(kAccessToken))
        accessToken = Utils.getUserDefault(kAccessToken)
        
        // Global configuration
        service.configure {
            $0.config.headers["Authorization"] = self.basicAuthHeader
            $0.config.responseTransformers.add(JitenshaErrorMessageExtractor())
            $0.config.responseTransformers.add(SwiftyJSONTransformer, contentTypes: ["*/json"])
        }
    }
    
    func logIn(username username: String, password: String) {
        
            let parameters = ["email": username, "password": password]
            service.resource("api/v1/auth").request(.POST, json: NSDictionary(dictionary: parameters)).onSuccess { data in
                debugPrint("success logging in")
                
                var contect : JSON = data.content as! JSON
                self.accessToken = contect[kAccessToken].string!
                Utils.setUserDefault(self.accessToken!, KeyToSave: kAccessToken)
                debugPrint(self.accessToken)
                
                self.signinDelegate?.didFinishWithUserLogin(true)
                
                }.onFailure { error in
                    debugPrint("failed to log in")
                    self.signinDelegate?.didFinishWithUserLogin(false)
                    Utils.setUserDefault("", KeyToSave: kAccessToken)
            }
    }
    
    func signUp(username username: String, password: String) {
        
        let parameters = ["email": username, "password": password]
        service.resource("api/v1/register").request(.POST, json: NSDictionary(dictionary: parameters)).onSuccess { data in
            debugPrint("User registration successfull")
            
            var contect : JSON = data.content as! JSON
            self.accessToken = contect[kAccessToken].string!
            Utils.setUserDefault(self.accessToken!, KeyToSave: kAccessToken)
            debugPrint(self.accessToken)
            
            self.signupDelegate?.didFinishWithUserSignup(true)
            
            }.onFailure { error in
                debugPrint("User registration faild")
                self.signupDelegate?.didFinishWithUserSignup(false)
                Utils.setUserDefault("", KeyToSave: kAccessToken)
        }
    }
    
    func fetchRentalPlaces() {
        
        service.configure {
            $0.config.headers["Authorization"] = self.accessToken
        }
        
        service.resource("api/v1/places").request(.GET).onSuccess { data in
            debugPrint("successfully fetched places")
            
            let contect : JSON = data.content as! JSON
            let results : JSON = contect["results"]
            
            var places : [Place] = []
            
            for i in 0..<results.arrayValue.count {
                
                var placeJson: JSON = JSON.null
                placeJson = results.arrayValue[i]
                let place : Place = Place(json: placeJson)
                places.append(place)
            }
            
            self.fetchPlaceDelegate?.didFinishFetchingPlacesWith(places)
            
            }.onFailure { error in
                debugPrint("failed to  fetched places")
                self.fetchPlaceDelegate?.didFinishFetchingPlacesWithError(error.userMessage)
        }
    }
    
    func sendPaymentWith(cardNumber: String, name: String, cvv: String, expiration: String) {
        
        let parameters = ["number": cardNumber, "name": name, "expiration": expiration, "code": cvv]
        
        service.resource("api/v1/rent").request(.POST, json: NSDictionary(dictionary: parameters)).onSuccess { data in
            debugPrint("Payment processing successfull")
            
            let contect : JSON = data.content as! JSON
            debugPrint(contect)
            let message : String = contect["message"].string!
            
            self.paymentDelegate?.didFinishPaymentWith(message)
            
            }.onFailure { error in
                debugPrint("Payment processing faild")
                self.paymentDelegate?.didFinishPaymentWithError(error.userMessage)
        }
    }
    
    func logOut() {
        basicAuthHeader = nil
    }
    
    var isAuthenticated: Bool {
        return basicAuthHeader != nil
    }
    
    
    private var basicAuthHeader: String? {
        didSet {
            service.invalidateConfiguration()  // So that future requests for existing resources pick up config change
            service.wipeResources()            // Scrub all unauthenticated data
        }
    }
    
    // Resource convenience accessors
    func user(username: String) -> Resource {
        return service.resource("users").child(username.lowercaseString)
    }
}




private struct JitenshaErrorMessageExtractor: ResponseTransformer {
    func process(response: Response) -> Response {
        switch response {
        case .Success:
            return response
            
        case .Failure(var error):
            error.userMessage = error.jsonDict["message"] as? String ?? error.userMessage
            return .Failure(error)
        }
    }
}

private let SwiftyJSONTransformer = ResponseContentTransformer(skipWhenEntityMatchesOutputType: false) {
    JSON($0.content as AnyObject)
}



