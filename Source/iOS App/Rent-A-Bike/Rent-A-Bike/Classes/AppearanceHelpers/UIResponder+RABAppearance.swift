//
//  UIResponder+RABAppearance.swift
//  Rent-A-Bike
//
//  Created by Partho Biswas on 5/27/16.
//  Copyright © 2016 Partho Biswas. All rights reserved.
//

import UIKit


extension AppDelegate {
    
    func applyDefaultAppearance() {
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        self.window!.tintColor = UIColor.appPrimaryColor()
        var attributes: [String : AnyObject] = [
                NSFontAttributeName : UIFont.appNavBarTitleFont(),
                NSForegroundColorAttributeName : UIColor.appNavigationBarForgroundColor()
            ]

        UINavigationBar.appearance().titleTextAttributes = attributes
        UINavigationBar.appearance().barTintColor = UIColor.appPrimaryColor()
        UITableView.appearance().separatorInset = UIEdgeInsetsZero
        UITableViewCell.appearance().separatorInset = UIEdgeInsetsZero
        if UITableView.instancesRespondToSelector(Selector("setLayoutMargins:")) {
            UITableView.appearance().layoutMargins = UIEdgeInsetsZero
            UITableViewCell.appearance().layoutMargins = UIEdgeInsetsZero
            UITableViewCell.appearance().preservesSuperviewLayoutMargins = false
        }
        UIBarButtonItem.appearance().setTitleTextAttributes([
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont.appLightFontWithSize(18.0)
        ]
, forState: .Normal)
        UITableView.appearance().separatorColor = UIColor.appTableViewSeperatorColor()
        UITableView.appearance().separatorStyle = .SingleLine
        UITableView.appearance().tableFooterView = UIView(frame: CGRectZero)
        UITextField.appearance().tintColor = UIColor.appPrimaryColor()
        UITextView.appearance().tintColor = UIColor.appPrimaryColor()
        UIBarButtonItem.appearance().setTitleTextAttributes([
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont.appLightFontWithSize(18)
        ]
, forState: .Normal)
        
        UIButton.appearance().backgroundColor = UIColor.appPrimaryColor()
        UIButton.appearance().tintColor = UIColor.whiteColor()
        UIButton.appearance().layer.cornerRadius = 10.0
        UIButton.appearance().layer.borderColor = UIColor.appSecondaryColor1().CGColor
        UIButton.appearance().layer.borderWidth = 2.0
       
        // Properties when tabbar is Selected
        UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName: UIFont.appRegularFontWithSize(10.0), NSForegroundColorAttributeName: UIColor.appPrimaryColor()], forState: .Selected)
        // Properties when tabbar is unselected
        UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName: UIFont.appRegularFontWithSize(10.0), NSForegroundColorAttributeName: UIColor.appTabBarForgroundColor()], forState: .Normal)
        
        UISearchBar.appearance().tintColor = UIColor.blackColor()
        UISearchBar.appearance().backgroundColor = UIColor.appSearchBarBackgroundColor()
        
        if #available(iOS 9.0, *) {
            UIView.appearanceWhenContainedInInstancesOfClasses([UIAlertController.self]).tintColor = UIColor.appPrimaryColor()
            UITextField.appearanceWhenContainedInInstancesOfClasses([UISearchBar.self]).backgroundColor = UIColor.whiteColor()
            UITextField.appearanceWhenContainedInInstancesOfClasses([UISearchBar.self]).defaultTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont.systemFontOfSize(14.0)]
            UITextField.appearanceWhenContainedInInstancesOfClasses([UISearchBar.self]).textColor = UIColor.blackColor()
            UILabel.appearanceWhenContainedInInstancesOfClasses([UISearchBar.self]).textColor = UIColor(red: 0.259, green: 0.259, blue: 0.259, alpha: 1.00)
            UITextField.appearanceWhenContainedInInstancesOfClasses([UISearchBar.self]).defaultTextAttributes = [NSForegroundColorAttributeName: UIColor.blackColor(), NSFontAttributeName: UIFont.systemFontOfSize(14.0)]
            UIBarButtonItem.appearanceWhenContainedInInstancesOfClasses([UISearchBar.self]).setTitleTextAttributes([
                NSForegroundColorAttributeName : UIColor(red: 0.259, green: 0.259, blue: 0.259, alpha: 1.00)
                ]
                , forState: .Normal)
            UILabel.appearanceWhenContainedInInstancesOfClasses([UISearchBar.self]).textColor = UIColor.blackColor()
        } else {
            // Fallback on earlier versions
        }
    }
}


