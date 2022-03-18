//
//  SectionFoodCollectionViewCell.swift
//  Jahez
//
//  Created by iOS Developer on 12/03/2022.
//

import UIKit

class SectionFoodCollectionViewCell: UICollectionViewCell {
    
    var section: SectionFoods! {
        didSet {
            self.labelName.text = section.name
            switch section.isSelected {
            case true:
                labelName.textColor = Colors.background
                self.contentView.backgroundColor = .white
            case false:
                labelName.textColor = .white
                self.contentView.backgroundColor = Colors.background
            }

        }
    }
    
    let labelName: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SectionFoodCollectionViewCell {
    func setupViews() {
        self.contentView.addSubview(labelName)
        
        labelName.topAnchor.constraint(equalTo:self.contentView.topAnchor, constant: 10).isActive = true
        labelName.bottomAnchor.constraint(equalTo:self.contentView.bottomAnchor, constant: -10).isActive = true
        labelName.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        labelName.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true

    }
}
