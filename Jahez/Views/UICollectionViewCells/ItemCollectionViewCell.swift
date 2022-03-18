//
//  ItemCollectionViewCell.swift
//  Jahez
//
//  Created by iOS Developer on 12/03/2022.
//

import UIKit
import SDWebImage

class ItemCollectionViewCell: UICollectionViewCell {
    
    var item: ItemFood! {
        didSet {
            self.labelName.text = item.name
            self.labelPrice.text = item.price
            self.imageViewItem.image = UIImage(named: item.imageName)
        }
    }
    
    var viewBachgroundItem: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.backgroundColor = .white
        view.addShadow()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let viewContainerImageViewItem: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.addShadow()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let imageViewItem: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center // image will never be strecthed vertially or horizontally
        imageView.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView

    }()
    
    let labelName: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .right
        label.numberOfLines = 0
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

    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let targetSize = CGSize(width: UIScreen.main.bounds.size.width / ((UIDevice.current.userInterfaceIdiom == .phone) ? 1 : 2), height: CGFloat.greatestFiniteMagnitude);
        layoutAttributes.frame.size = contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel);
        
        return layoutAttributes;
    }
}

extension ItemCollectionViewCell {
    func setupViews() {
        self.contentView.addSubview(viewBachgroundItem)
        self.contentView.addSubview(labelName)
        self.contentView.addSubview(labelPrice)
        self.contentView.addSubview(viewContainerImageViewItem)
        viewContainerImageViewItem.addSubview(imageViewItem)

        
        viewContainerImageViewItem.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15).isActive = true
        viewContainerImageViewItem.centerXAnchor.constraint(equalTo:self.contentView.centerXAnchor).isActive = true
        viewContainerImageViewItem.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, constant: -40).isActive = true
        var anchor = viewContainerImageViewItem.heightAnchor.constraint(equalToConstant:140)
        anchor.priority = UILayoutPriority(999)
        anchor.isActive = true
        
        imageViewItem.centerYAnchor.constraint(equalTo: self.viewContainerImageViewItem.centerYAnchor).isActive = true
        imageViewItem.centerXAnchor.constraint(equalTo: self.viewContainerImageViewItem.centerXAnchor).isActive = true
        imageViewItem.widthAnchor.constraint(equalTo: self.viewContainerImageViewItem.widthAnchor).isActive = true
        imageViewItem.heightAnchor.constraint(equalTo: self.viewContainerImageViewItem.heightAnchor).isActive = true
        
//        labelName.topAnchor.constraint(equalTo:self.viewContainerImageViewItem.bottomAnchor, constant: 10).isActive = true
//        labelName.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant: 30).isActive = true
//

        anchor = labelPrice.topAnchor.constraint(equalTo:self.contentView.topAnchor, constant: 160)
        anchor.isActive = true
        labelPrice.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20).isActive = true
        labelPrice.widthAnchor.constraint(lessThanOrEqualToConstant: 120).isActive = true
        
        anchor = labelName.topAnchor.constraint(equalTo:self.contentView.topAnchor, constant: 160)
        anchor.priority = UILayoutPriority(999)
        anchor.isActive = true
        labelName.bottomAnchor.constraint(equalTo:self.contentView.bottomAnchor).isActive = true
        labelName.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true
        labelName.trailingAnchor.constraint(lessThanOrEqualTo: self.labelPrice.leadingAnchor, constant: 20).isActive = true
        
        viewBachgroundItem.topAnchor.constraint(equalTo:self.contentView.topAnchor, constant: 5).isActive = true
        viewBachgroundItem.bottomAnchor.constraint(equalTo:self.labelName.bottomAnchor, constant: 5).isActive = true
        viewBachgroundItem.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        viewBachgroundItem.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true

        
    }
}
