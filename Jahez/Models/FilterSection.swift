//
//  Filter.swift
//  Jahez
//
//  Created by iOS Developer on 07/03/2022.
//

import Foundation
class FilterSection {
    public var imageName: String = ""
    public var name         : String = ""
    public var index        : Int = -1
    public var isSelected   : Bool = true
    init() {
        
    }
    
    init(name: String, imageName: String, index: Int, isSelected: Bool) {
        self.name = name
        self.imageName = imageName
        self.index = index
        self.isSelected = isSelected
    }
}
