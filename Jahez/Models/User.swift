//
//  User.swift
//  Jahez
//
//  Created by iOS Developer on 18/03/2022.
//

import Foundation
import SwiftyJSON

class User {
    
    static var userIsLoggedIn: Bool = UserDefaults.standard.bool(forKey: "userIsLoggedIn")
    static public var id       : String = UserDefaults.standard.string(forKey: "id") ?? ""
    static public var name     : String = UserDefaults.standard.string(forKey: "name") ?? ""
    static public var phone    : String = UserDefaults.standard.string(forKey: "phone") ?? ""
    static public var balance  : String = UserDefaults.standard.string(forKey: "balance") ?? ""
    
    init() {
        
    }
    
    init(json: JSON) {
        UserDefaults.standard.setValue(json["id"].stringValue, forKey: "id")
        User.id = json["id"].stringValue
        UserDefaults.standard.setValue(json["name"].stringValue, forKey: "name")
        User.name = json["name"].stringValue
        UserDefaults.standard.setValue(json["phone"].stringValue, forKey: "phone")
        User.phone = json["phone"].stringValue
        UserDefaults.standard.setValue(json["balance"].stringValue, forKey: "balance")
        User.balance = json["balance"].stringValue
    }
    
    static func deleteAllData() {
        UserDefaults.standard.setValue(false, forKey: "userIsLoggedIn")
        UserDefaults.standard.removeObject(forKey: "id")
        UserDefaults.standard.removeObject(forKey: "name")
        UserDefaults.standard.removeObject(forKey: "phone")
        UserDefaults.standard.removeObject(forKey: "balance")
        
        User.id = ""
        User.name = ""
        User.phone = ""
        User.balance = ""
        User.userIsLoggedIn = false
        
    }
    
}
