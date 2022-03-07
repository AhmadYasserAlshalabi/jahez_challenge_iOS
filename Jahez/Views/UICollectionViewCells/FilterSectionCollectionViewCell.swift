//
//  FilterSectionCollectionViewCell.swift
//  Jahez
//
//  Created by iOS Developer on 07/03/2022.
//

import UIKit

class FilterSectionCollectionViewCell: UICollectionViewCell {
    
    var index: Int!
    var filterSection: FilterSection! {
        didSet {
            self.index = filterSection.index
            if filterSection.isSelected {
                self.imageViewFilterSection.image = UIImage(named: filterSection.imageName)
            } else {
                self.imageViewFilterSection.image = UIImage(named: filterSection.imageName)?.noir
            }
        }
    }
    
    let imageViewFilterSection: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
        imageView.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        imageView.clipsToBounds = true
//        imageView.circlesView()
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension FilterSectionCollectionViewCell {
    func setupViews() {
        contentView.addSubview(imageViewFilterSection)
        imageViewFilterSection.topAnchor.constraint(equalTo:self.contentView.topAnchor).isActive = true
        imageViewFilterSection.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor).isActive = true
        imageViewFilterSection.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor).isActive = true
        imageViewFilterSection.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
//        imageViewFilterSection.circlexssView()
        
    }
}
