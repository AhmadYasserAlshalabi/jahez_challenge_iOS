//
//  GetRestaurantsDataTest.swift
//  JahezTests
//
//  Created by iOS Developer on 07/03/2022.
//

import Foundation
import XCTest
@testable import Jahez

class GetRestaurantsDataTest: XCTestCase {
    
    let vc = UIViewController()
    
    override func setUp() {
        
    }
    
    func testGetRestaurantsData() {
        
        vc.getRestaurantData { restaurants in

//            XCTAssertTrue(restaurants.count < 0)
            XCTAssertFalse(restaurants.count < 0)

        }
        
    }
    
}
