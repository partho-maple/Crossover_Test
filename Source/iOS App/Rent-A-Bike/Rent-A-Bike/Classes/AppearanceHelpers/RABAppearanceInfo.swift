//
//  RABAppearanceInfo.swift
//  Rent-A-Bike
//
//  Created by Partho Biswas on 5/27/16.
//  Copyright © 2016 Partho Biswas. All rights reserved.
//

import Foundation
import UIKit


var localAppearanceDictionary: [NSObject : AnyObject]? = nil
let kRegularFontNameKey: String = "RegularFontNameKey"
let kMediumFontNameKey: String = "MediumFontNameKey"
let kLightFontNameKey: String = "LightFontNameKey"
let kPrimaryAppColorKey: String = "PrimaryAppColorKey"
let kSecondaryColor1Key: String = "SecondaryColor1Key"
let kSearchBarBackgroundColor: String = "SearchBarBackgroundColorKey"
let kNavigationBarForgroundColor: String = "NavigationBarForgroundColorKey"
let kTableViewSeperatorColor: String = "TableViewSeperatorColorKey"
let kTabBarForgroundColor: String = "TabBarForgroundColorKey"
let kAboutViewHeaderColor: String = "AboutViewHeaderColorKey"
let kAppTableViewCellDescriptionColor: String = "appTableViewCellDescriptionColorKey"
let kBorderLineColor: String = "LightGrayBorderColorKey"


class RABAppearanceInfo: NSObject {
    
    class func setAppearanceDictionary(appearanceDictionary: [NSObject : AnyObject]) {
        localAppearanceDictionary = appearanceDictionary
    }
    
    class func valueForAppearanceKey(key: String) -> AnyObject {
        if (localAppearanceDictionary != nil) {
            return localAppearanceDictionary![key]!;
        } else {
            return self.defaultAppearanceDictionary()[key]!
        }
    }

    class func defaultAppearanceDictionary() -> [NSObject : AnyObject] {
        
        return [kRegularFontNameKey: "Helvetica", kMediumFontNameKey: "Helvetica-Medium", kLightFontNameKey: "Helvetica-Light", kPrimaryAppColorKey: UIColor(red: 250.0 / 250.0, green: 110.0 / 250.0, blue: 40.0 / 250.0, alpha: 1.0), kSecondaryColor1Key: UIColor(red: 200.0 / 250.0, green: 100.0 / 250.0, blue: 40.0 / 250.0, alpha: 1.0), kBorderLineColor: UIColor(white: 0.749, alpha: 1.000), kSearchBarBackgroundColor: UIColor(red: 251.0 / 255.0, green: 147.0 / 255.0, blue: 96.0 / 255.0, alpha: 1.0), kNavigationBarForgroundColor: UIColor.whiteColor(), kTableViewSeperatorColor: UIColor(red: 214.0 / 255, green: 213.0 / 255, blue: 214.0 / 255, alpha: 0.5), kTabBarForgroundColor: UIColor(red: 0.35, green: 0.34, blue: 0.33, alpha: 1), kAboutViewHeaderColor: UIColor(red:213/255.0, green: 213/255.0, blue: 213/255.0, alpha: 1.0), kAppTableViewCellDescriptionColor: UIColor(red:66/255.0, green: 66/255.0, blue: 66/255.0, alpha: 1.0)]
    }
}


