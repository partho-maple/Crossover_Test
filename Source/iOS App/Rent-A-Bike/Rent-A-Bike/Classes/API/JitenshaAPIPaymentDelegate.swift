//
//  JitenshaAPIPaymentDelegate.swift
//  Rent-A-Bike
//
//  Created by Partho Biswas on 5/28/16.
//  Copyright © 2016 Partho Biswas. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON


protocol JitenshaAPIPaymentDelegate {
    
    func didFinishPaymentWith(successMsg: String)
    func didFinishPaymentWithError(errorMsg: String)
    
}
