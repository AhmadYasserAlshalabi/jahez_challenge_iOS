//
//  FilterSectionProtocol.swift
//  Jahez
//
//  Created by iOS Developer on 07/03/2022.
//

import Foundation

protocol FilterSectionDelegate: AnyObject {
    func clickFilterSection(index: Int)
    func clickMenuSection(index: Int)
}
