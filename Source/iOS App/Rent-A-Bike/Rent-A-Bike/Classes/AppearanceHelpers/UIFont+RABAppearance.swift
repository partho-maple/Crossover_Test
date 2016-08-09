//
//  UIFont+RABAppearance.swift
//  Rent-A-Bike
//
//  Created by Partho Biswas on 5/27/16.
//  Copyright © 2016 Partho Biswas. All rights reserved.
//
import UIKit
extension UIFont {
    class func appRegularFontWithSize(size: CGFloat) -> UIFont {
        return UIFont(name: RABAppearanceInfo.valueForAppearanceKey(kRegularFontNameKey) as! String, size: size)!
    }

    class func appMediumFontWithSize(size: CGFloat) -> UIFont {
        return UIFont(name: RABAppearanceInfo.valueForAppearanceKey(kMediumFontNameKey) as! String, size: size)!
        
    }

    class func appLightFontWithSize(size: CGFloat) -> UIFont {
        return UIFont(name: RABAppearanceInfo.valueForAppearanceKey(kLightFontNameKey) as! String, size: size)!
    }

    class func appNavBarTitleFont() -> UIFont {
        return UIFont.appRegularFontWithSize(18.0)
    }

    class func appBarButtonItemTitleFont() -> UIFont {
        return UIFont.appLightFontWithSize(18.0)
    }
}


