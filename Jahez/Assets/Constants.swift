//
//  Constants.swift
//  Jahez
//
//  Created by iOS Developer on 05/03/2022.
//

import Foundation
import UIKit

class Constants {
    
    static let statusBarHeight = UIApplication.shared.connectedScenes
        .filter {$0.activationState == .foregroundActive }
        .map {$0 as? UIWindowScene }
        .compactMap { $0 }
        .first?.windows
        .filter({ $0.isKeyWindow }).first?
        .windowScene?.statusBarManager?.statusBarFrame.height ?? 0

}
