//
//  Filter.swift
//  Jahez
//
//  Created by iOS Developer on 07/03/2022.
//

import Foundation
class MenuSection: Hashable {
    
    static func == (lhs: MenuSection, rhs: MenuSection) -> Bool {
        return true
    }
    
    var hashValue: Int {
        return 0
    }
    
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
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.name)
        hasher.combine(self.index)
    }

}
extension MenuSection { }
