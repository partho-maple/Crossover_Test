//
//  SignInViewController.swift
//  Rent-A-Bike
//
//  Created by Partho Biswas on 5/27/16.
//  Copyright © 2016 Partho Biswas. All rights reserved.
//

import UIKit
import Siesta
import ARSLineProgress
import JLToast
import SwiftyJSON

class SignInViewController: UIViewController, JitenshaAPISigninDelegate {
    
    
    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var passwordTestfield: UITextField!
    
    let statusOverlay = ResourceStatusOverlay()

    override func viewDidLoad() {
        super.viewDidLoad()

        JitenshaAPI.signinDelegate = self
        
        // Add tap gesture recognizer to view
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SignInViewController.hideKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func hideKeyboard() {
        self.view!.endEditing(true)
        self.view!.resignFirstResponder()
    }

 
    // MARK: - API call delegate
    func didFinishWithUserLogin(success: Bool) {
        
        dispatch_async(dispatch_get_main_queue(),{
            [unowned self] in
            
            ARSLineProgress.hide()
            
            if success {
                self.performSegueWithIdentifier("FromSigninToMapSegue", sender: self)
            } else {
                let toast = JLToast.makeText("Login faild", delay: 1, duration: 3)
                toast.show()
            }
            
        })
     }
    
    // MARK: - Button Actions
    
    @IBAction func signInButtonAction(sender: AnyObject) {
        guard let email = usernameTextfield.text  where !usernameTextfield.text!.isEmpty else {
            usernameTextfield.becomeFirstResponder()
            return
        }
        guard let password = passwordTestfield.text  where !passwordTestfield.text!.isEmpty else {
            passwordTestfield.becomeFirstResponder()
            return
        }
        
        if Utils.isConnectedToNetwork() {
            ARSLineProgress.show()
            JitenshaAPI.logIn(username: email, password: password)
        } else {
            let toast = JLToast.makeText("Internet connection not available.", delay: 1, duration: 3)
            toast.show()
        }
    }
    
    @IBAction func signupButtonAction(sender: AnyObject) {
        self.performSegueWithIdentifier("FromSigninToSignupSegue", sender: self)
    }
    
}
