//
//  SignupViewController.swift
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

class SignupViewController: UIViewController, JitenshaAPISignupDelegate {

    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var passwordTestfield: UITextField!
    @IBOutlet weak var signupButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        JitenshaAPI.signupDelegate = self
        
        self.navigationController!.navigationBar.translucent = false
        let closeButtonImage: UIImage = UIImage(named: "backButton")!.imageWithRenderingMode(.AlwaysOriginal)
        let barBackButtonItem: UIBarButtonItem = UIBarButtonItem(image: closeButtonImage, style: .Plain, target: self, action: #selector(SignupViewController.popCurrentViewController))
        self.navigationItem.leftBarButtonItem = barBackButtonItem
        self.navigationItem.hidesBackButton = true
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        
        // Add tap gesture recognizer to view
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SignupViewController.hideKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: - API call delegate
    func didFinishWithUserSignup(success: Bool) {
        dispatch_async(dispatch_get_main_queue(),{
            [unowned self] in
            ARSLineProgress.hide()
            if success {
                self.performSegueWithIdentifier("FromSignupToMapSegue", sender: self)
                
                let toast = JLToast.makeText("Registration successfull", delay: 1, duration: 3)
                toast.show()
            } else {
                let toast = JLToast.makeText("Registration faild", delay: 1, duration: 3)
                toast.show()
            }

        })
    }
    
    // MARK: - Member methodes
    
    func popCurrentViewController() {
        self.navigationController!.popViewControllerAnimated(true)
    }
    
    func hideKeyboard() {
        self.view!.endEditing(true)
        self.view!.resignFirstResponder()
    }
    
    @IBAction func signupButtonAction(sender: AnyObject) {
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
            JitenshaAPI.signUp(username: email, password: password)
        } else {
            let toast = JLToast.makeText("Internet connection not available.", delay: 1, duration: 3)
            toast.show()
        }
    }
    
}
