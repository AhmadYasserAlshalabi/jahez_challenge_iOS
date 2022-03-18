//
//  RestaurantCollectionViewCell_.swift
//  Jahez
//
//  Created by iOS Developer on 04/03/2022.
//

import UIKit
import SDWebImage

class RestaurantCollectionViewCell_1: UICollectionViewCell {
    
    var  restaurant: Restaurant! {
        didSet {
            self.labelName.text = restaurant.name
            self.labelDistance.text = restaurant.distance.description
            self.imageViewRestaurant.sd_setImage(with: URL(string: restaurant.image)) { (image, error, type, url) in
                if !(error == nil && image != nil){
                    self.imageViewRestaurant.image = nil
                }
            }
        }
    }
    
    let containerView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true // this will make sure its children do not go out of the boundary
        return view
    }()
    
    var viewBachground: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        view.addShadow()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let viewContainerImageViewRestaurant: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 8
        view.addShadow()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let imageViewRestaurant: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
        imageView.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let labelName: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelDistance: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor =  .black
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label

    }()
    
    let imageViewMap: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
        imageView.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "pinMap")
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

extension RestaurantCollectionViewCell_1 {
    func setupViews() {
        contentView.addSubview(viewBachground)
        contentView.addSubview(viewContainerImageViewRestaurant)
        viewContainerImageViewRestaurant.addSubview(imageViewRestaurant)
        containerView.addSubview(labelName)
        containerView.addSubview(labelDistance)
        containerView.addSubview(imageViewMap)
        contentView.addSubview(containerView)
        
        viewContainerImageViewRestaurant.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        viewContainerImageViewRestaurant.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        viewContainerImageViewRestaurant.widthAnchor.constraint(equalToConstant:70).isActive = true
        viewContainerImageViewRestaurant.heightAnchor.constraint(equalToConstant:70).isActive = true
        
        imageViewRestaurant.centerYAnchor.constraint(equalTo:self.viewContainerImageViewRestaurant.centerYAnchor).isActive = true
        imageViewRestaurant.centerXAnchor.constraint(equalTo:self.viewContainerImageViewRestaurant.centerXAnchor).isActive = true
        imageViewRestaurant.widthAnchor.constraint(equalToConstant:70).isActive = true
        imageViewRestaurant.heightAnchor.constraint(equalToConstant:70).isActive = true
        
        viewBachground.anchor(top: self.contentView.topAnchor,
                              paddingTop: 4,
                              bottom: self.contentView.bottomAnchor,
                              paddingBottom: 4,
                              left: self.contentView.leadingAnchor,
                              paddingLeft: 4,
                              right: self.contentView.trailingAnchor,
                              paddingRight: -4,
                              width: 0,
                              height: 0)
        
        containerView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo:self.viewContainerImageViewRestaurant.trailingAnchor, constant:10).isActive = true
        containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
        containerView.heightAnchor.constraint(equalToConstant:70).isActive = true
        
        labelName.topAnchor.constraint(equalTo:self.containerView.topAnchor, constant: 10).isActive = true
        labelName.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        labelName.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
        
        labelDistance.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        labelDistance.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        labelDistance.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor).isActive = true
        
        imageViewMap.leadingAnchor.constraint(equalTo:self.labelDistance.trailingAnchor, constant: 3).isActive = true
        imageViewMap.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor).isActive = true
        imageViewMap.widthAnchor.constraint(equalToConstant:15).isActive = true
        imageViewMap.heightAnchor.constraint(equalToConstant:15).isActive = true

    }
}
