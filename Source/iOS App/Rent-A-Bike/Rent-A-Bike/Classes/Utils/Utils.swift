//
//  Utils.swift
//  Rent-A-Bike
//
//  Created by Partho Biswas on 5/27/16.
//  Copyright © 2016 Partho Biswas. All rights reserved.
//

import UIKit
import Foundation
import SystemConfiguration

class Utils {
    
    static let screenSize: CGRect = UIScreen.mainScreen().bounds
    static let screenWidth = screenSize.width
    static let screenHeight = screenSize.height
    
    class func setUserDefault(ObjectToSave : String , KeyToSave : String) {
        let defaults = NSUserDefaults.standardUserDefaults()
        
//        let base64String = try! ObjectToSave.encrypt(AES(key: kPrivateEncoderDecoderKey, iv: "5")).toBase64()
        defaults.setObject(ObjectToSave, forKey: KeyToSave)
        
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    class func getUserDefault(KeyToReturnValye : String) -> String? {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let name:String = defaults.valueForKey(KeyToReturnValye) as? String {
//            let decryptedName = try! name.decryptBase64ToString(AES(key: kPrivateEncoderDecoderKey, iv: "5"))
            
            return name
        }
        return nil
    }
    
    class func convertJsonStringToDictionary(text: String) -> [String:AnyObject]? {
        if let data = text.dataUsingEncoding(NSUTF8StringEncoding) {
            do {
                return try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [String:AnyObject]
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }
    
    
    class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
            SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, UnsafePointer($0))
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        let isReachable = flags == .Reachable
        let needsConnection = flags == .ConnectionRequired
        
        return isReachable && !needsConnection
        
    }
    
}

