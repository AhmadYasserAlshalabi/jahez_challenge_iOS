//
//  Offer.swift
//  Jahez
//
//  Created by iOS Developer on 08/03/2022.
//

import Foundation
import SwiftyJSON

class Offer {
    public var id           : String = ""
    public var name         : String = ""
    public var image        : String = ""
    public var description  : String = ""

    init() {
        
    }
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
    
    init(json: JSON) {
        id          = json["id"].stringValue
        name        = json["name"].stringValue
        image       = json["image"].stringValue
        description = json["description"].stringValue
    }
}
