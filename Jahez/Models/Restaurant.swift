//
//  Restaurant.swift
//  Jahez
//
//  Created by iOS Developer on 04/03/2022.
//

import Foundation
import SwiftyJSON

class Restaurant {
//    "id": 2,
//    "name": "Shawarma Classic",
//    "description": "Enjoy fast delivery from Jahez. Order now, or schedule your order any time you want",
//    "hours": "11:30 AM - 02:00 AM",
//    "image": "https://jahez-other-oniiphi8.s3.eu-central-1.amazonaws.com/2.jpg",
//    "rating": 8.0,
//    "distance": 1.5690683590005408,
//    "hasOffer": true,
//    "offer": "9 Ø±ÙŠØ§Ù„"
    public var id           : String = ""
    public var name         : String = ""
    public var description  : String = ""
    public var hours        : String = ""
    public var rating       : String = ""
    public var image        : String = ""
    public var distance     : Float = 0.0
    public var offer        : String = ""
    public var hasOffer     : Bool = false

    init() {
        
    }
    
    init(json: JSON) {
        
        id          = json["id"].stringValue
        name        = json["name"].stringValue
        description = json["description"].stringValue
        hours       = json["hours"].stringValue
        rating      = json["rating"].stringValue
        image       = json["image"].stringValue
        distance    = roundf(json["distance"].floatValue * 100) / 100

        offer       = json["offer"].stringValue
        hasOffer    = json["hasOffer"].boolValue
        
    }
    
}

