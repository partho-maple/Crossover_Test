//
//  Place.swift
//  Rent-A-Bike
//
//  Created by Partho Biswas on 5/27/16.
//  Copyright © 2016 Partho Biswas. All rights reserved.
//

import Foundation
import SwiftyJSON


struct Place {
    
    let identifire : String?
    let location : Location?
    let name : String?
    
    init(json: JSON) {
        identifire           = json["id"].string
        location            = Location(json: json["location"])
        name = json["name"].string
    }
}

