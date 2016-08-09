//
//  JitenshaAPIFetchDelegate.swift
//  Rent-A-Bike
//
//  Created by Partho Biswas on 5/27/16.
//  Copyright © 2016 Partho Biswas. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON


protocol JitenshaAPIFetchDelegate {
    
    func didFinishFetchingPlacesWith(places: [Place])
    func didFinishFetchingPlacesWithError(errorMsg: String)
    
}
