//
//  NotLoginLabel.swift
//  Jahez
//
//  Created by iOS Developer on 15/03/2022.
//

import UIKit

class NotLoginLabel: UILabel {
    
    override var intrinsicContentSize: CGSize {
        let originalInterinsicContentSize = super.intrinsicContentSize
        let height = originalInterinsicContentSize.height + 12
        self.roundCorners(corners: [.topLeft, .bottomLeft], radius: height / 2)
        layer.masksToBounds = true
        self.backgroundColor = Colors.background
        self.textColor = .white
        self.textAlignment = .left
        self.text = "You are not logged in, log in now"
        self.translatesAutoresizingMaskIntoConstraints = false
        return CGSize(width: originalInterinsicContentSize.width + 12, height: height)
    }

}
