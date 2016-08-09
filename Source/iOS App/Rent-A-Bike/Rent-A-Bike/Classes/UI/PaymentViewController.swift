//
//  PaymentViewController.swift
//  Rent-A-Bike
//
//  Created by Partho Biswas on 5/28/16.
//  Copyright © 2016 Partho Biswas. All rights reserved.
//

import UIKit
import Siesta
import ARSLineProgress
import JLToast
import SwiftyJSON
import GoogleMaps
import CoreLocation

class PaymentViewController: UIViewController, JitenshaAPIPaymentDelegate {
        
    @IBOutlet weak var cardNumberTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var cvvTextField: UITextField!
    @IBOutlet weak var expiryDateTextField: UITextField!
    @IBOutlet weak var renuButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        JitenshaAPI.paymentDelegate = self
        
        self.navigationController!.navigationBar.translucent = false
        let closeButtonImage: UIImage = UIImage(named: "backButton")!.imageWithRenderingMode(.AlwaysOriginal)
        let barBackButtonItem: UIBarButtonItem = UIBarButtonItem(image: closeButtonImage, style: .Plain, target: self, action: #selector(PaymentViewController.popCurrentViewController))
        self.navigationItem.leftBarButtonItem = barBackButtonItem
        self.navigationItem.hidesBackButton = true
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        
        let expiryDatePickerWIdth = Utils.screenWidth - 40
        let expiryDatePickerHeight = Utils.screenHeight * 0.385
        
        let expiryDatePicker = MonthYearPickerView(frame: CGRectMake(20, (Utils.screenHeight - expiryDatePickerHeight), expiryDatePickerWIdth, expiryDatePickerHeight))
        self.expiryDateTextField.inputView = expiryDatePicker
        expiryDatePicker.onDateSelected = { (month: Int, year: Int) in
            let expireString = String(format: "%02d/%02d", month, year)
            self.expiryDateTextField.text = expireString
        }
        
        
        // Add tap gesture recognizer to view
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(PaymentViewController.hideKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    // MARK: - JitenshaAPIPaymentDelegate methodes
    
    func didFinishPaymentWith(successMsg: String) {
        
        dispatch_async(dispatch_get_main_queue(),{
            [unowned self] in
            
            ARSLineProgress.hide()
            let toast = JLToast.makeText(successMsg, delay: 1, duration: 3)
            toast.show()
            self.renuButton.enabled = true
        })
    }
    
    func didFinishPaymentWithError(errorMsg: String) {
        
        dispatch_async(dispatch_get_main_queue(),{
            [unowned self] in
            ARSLineProgress.hide()
            let toast = JLToast.makeText(errorMsg, delay: 1, duration: 3)
            toast.show()
            self.renuButton.enabled = true

        })
    }


    // MARK: - Member methodes
    
    func popCurrentViewController() {
        self.navigationController!.popViewControllerAnimated(true)
    }
    
    
    @IBAction func rentButtonAction(sender: AnyObject) {
        self.hideKeyboard()
        
        // For test purpose
//        JitenshaAPI.sendPaymentWith("1234567891234567", name: "Partho Biswas", cvv: "987", expiration: "09/2019")
//        return
        
        guard let cardNumber = cardNumberTextField.text  where !cardNumberTextField.text!.isEmpty else {
            cardNumberTextField.becomeFirstResponder()
            return
        }
        
        guard let name = nameTextField.text  where !nameTextField.text!.isEmpty else {
            nameTextField.becomeFirstResponder()
            return
        }
        
        guard let cvvNumber = cvvTextField.text  where !cvvTextField.text!.isEmpty else {
            cvvTextField.becomeFirstResponder()
            return
        }
        
        guard let expiryDate = expiryDateTextField.text  where !expiryDateTextField.text!.isEmpty else {
            expiryDateTextField.becomeFirstResponder()
            return
        }
        
        ARSLineProgress.show()
        JitenshaAPI.sendPaymentWith(cardNumber, name: name, cvv: cvvNumber, expiration: expiryDate)
        self.renuButton.enabled = false
    }
    
    func hideKeyboard() {
        self.view!.endEditing(true)
        self.view!.resignFirstResponder()
    }
    
}
