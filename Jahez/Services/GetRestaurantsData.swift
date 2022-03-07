//
//  GetRestaurantsData.swift
//  Jahez
//
//  Created by iOS Developer on 04/03/2022.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

extension UIViewController {
    func getRestaurantData(completition: @escaping(_ restaurants: [Restaurant])->(Void)) {
        let url = URL(string: "https://jahez-other-oniiphi8.s3.eu-central-1.amazonaws.com/restaurants.json")!
        
        AF.request(url, method: .get, parameters: [:])
//                .authenticate(usingCredential: credential!)
            .responseJSON() { response in

            switch response.result {
            case .success(_):
                switch response.response?.statusCode {
                case 200, 201, 202, 203, 204:
                    let json: JSON = JSON(response.data!)
                    var restaurants: [Restaurant] = []
                    for item in json.arrayValue {
                        restaurants.append(Restaurant(json: item))
                    }
                    print(json)
                    completition(restaurants)
                case 401:
                    print("\n\nUnAuthorization error \(url) (401) \n\n")
                case 400:
                    print("\n\nFailure error \(url) (400) \n\n")
                case 500, 501, 502, 503, 504, 529:
                    print("\n\nserver error \(url) (\(response.response?.statusCode.description ?? "")) \n\n")
                default:
                    ()
                }
            case .failure(_):
                switch response.response?.statusCode {
                case 401:
                    print("\n\nUnAuthorization error \(url) (401) \n\n")
                case 400:
                    print("\n\nFailure error \(url) (401) \n\n")
                case 500, 501, 502, 503, 504, 529:
                    print("\n\nserver error \(url) (\(response.response?.statusCode.description ?? "")) \n\n")
                default:
                    ()
                }
            }
            
        }
    }
}
