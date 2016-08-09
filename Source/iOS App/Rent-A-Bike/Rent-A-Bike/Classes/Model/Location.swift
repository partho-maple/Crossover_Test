//
//  Location.swift
//  Rent-A-Bike
//
//  Created by Partho Biswas on 5/27/16.
//  Copyright © 2016 Partho Biswas. All rights reserved.
//

import Foundation
import SwiftyJSON


struct Location {
    let lat, lng: Double?
    
    init(json: JSON) {
        lat           = json["lat"].double
        lng            = json["lng"].double
    }
}
