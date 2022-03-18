//
//  SectionFood.swift
//  Jahez
//
//  Created by iOS Developer on 12/03/2022.
//

import Foundation
import Foundation
class SectionFoods {
    
    public var name         : String = ""
    public var id           : Int = -1
    public var isSelected   : Bool = true
    public var itemsFoods   : [ItemFood] = []
    
    init() {
        
    }
    
    init(name: String, id: Int, isSelected: Bool, itemsFoods: [ItemFood]) {
        self.name = name
        self.id = id
        self.isSelected = isSelected
        self.itemsFoods = itemsFoods
    }

}

class ItemFood {
    
    public var imageName    : String = ""
    public var name         : String = ""
    public var price        : String = "25 SAR"
    public var count        : Int = 1
    public var description  : String = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum"
    public var id           : Int = -1
    public var isSelected   : Bool = true
    
    init() {
        
    }
    
    init(name: String, imageName: String, id: Int, isSelected: Bool) {
        self.name = name
        self.imageName = imageName
        self.id = id
        self.isSelected = isSelected
    }

}
