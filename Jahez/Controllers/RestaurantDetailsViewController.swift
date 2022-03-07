//
//  RestaurantDetailsViewController.swift
//  Jahez
//
//  Created by iOS Developer on 04/03/2022.
//

import UIKit

class RestaurantDetailsViewController: UIViewController {
    
    var  restaurant: Restaurant! {
        didSet {
            self.labelName.text = restaurant.name
            self.labelDescription.text = restaurant.description
            self.labelHours.text = "open: " + restaurant.hours
            self.labelRating.text = restaurant.rating
            self.imageViewRestaurant.sd_setImage(with: URL(string: restaurant.image)) { (image, error, type, url) in
                if !(error == nil && image != nil){
                    self.imageViewRestaurant.image = nil
                }
            }
        }
    }
    
    var viewBachground: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.backgroundColor = .white
        view.addShadow()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var viewBachgroundRestaurant: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.backgroundColor = .white
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
        imageView.contentMode = .center // image will never be strecthed vertially or horizontally
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
    
    let labelDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor =  .black
        label.numberOfLines = 0
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let viewContainerStackHoursAndRating: UIView = {
        let view = UIView()
//        view.backgroundColor = .blue
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.addShadow()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let stackViewHoursAndRating: UIStackView = {
        let stackView = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.horizontal
        stackView.alignment = UIStackView.Alignment.fill
        stackView.distribution = UIStackView.Distribution.fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false;
        return stackView
    }()

    let viewContainerHours: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let viewContainerRating: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let labelHours: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor =  .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelRating: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor =  .black
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let stackViewRatingCircles: UIStackView = {
        let stackView = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.horizontal
        stackView.alignment = UIStackView.Alignment.fill
        stackView.distribution = UIStackView.Distribution.fill
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false;
        return stackView
    }()

}

//MARK: - LifeCycle:
extension RestaurantDetailsViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNavigationBarTitleImage()
        self.view.backgroundColor = Colors.background
        self.setupViews(rating: Int(self.restaurant.rating)!)
    }

}

extension RestaurantDetailsViewController {
    func setupViews(rating: Int) {
        self.view.addSubview(viewBachground)
        self.view.addSubview(viewBachgroundRestaurant)
        self.view.addSubview(viewContainerImageViewRestaurant)
        viewContainerImageViewRestaurant.addSubview(imageViewRestaurant)
        self.view.addSubview(labelName)
        self.view.addSubview(labelDescription)
        self.view.addSubview(viewContainerStackHoursAndRating)
        
        self.viewContainerHours.addSubview(labelHours)
        self.viewContainerRating.addSubview(stackViewRatingCircles)
        
        self.viewContainerStackHoursAndRating.addSubview(stackViewHoursAndRating)
        
        stackViewHoursAndRating.addArrangedSubview(viewContainerHours)
        stackViewHoursAndRating.addArrangedSubview(viewContainerRating)

        viewContainerImageViewRestaurant.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        viewContainerImageViewRestaurant.centerXAnchor.constraint(equalTo:self.view.centerXAnchor).isActive = true
        viewContainerImageViewRestaurant.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -40).isActive = true
        viewContainerImageViewRestaurant.heightAnchor.constraint(equalToConstant:150).isActive = true
        
        imageViewRestaurant.centerYAnchor.constraint(equalTo: self.viewContainerImageViewRestaurant.centerYAnchor).isActive = true
        imageViewRestaurant.centerXAnchor.constraint(equalTo: self.viewContainerImageViewRestaurant.centerXAnchor).isActive = true
        imageViewRestaurant.widthAnchor.constraint(equalTo: self.viewContainerImageViewRestaurant.widthAnchor).isActive = true
        imageViewRestaurant.heightAnchor.constraint(equalTo: self.viewContainerImageViewRestaurant.heightAnchor).isActive = true
        
        
        
        labelName.topAnchor.constraint(equalTo:self.viewContainerImageViewRestaurant.bottomAnchor, constant: 10).isActive = true
        labelName.leadingAnchor.constraint(equalTo:self.view.leadingAnchor, constant: 30).isActive = true
        
        labelName.widthAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        
        labelDescription.topAnchor.constraint(equalTo: self.viewContainerImageViewRestaurant.bottomAnchor, constant: 10).isActive = true
        labelDescription.leadingAnchor.constraint(equalTo:self.labelName.trailingAnchor, constant: 10).isActive = true
        labelDescription.trailingAnchor.constraint(equalTo:self.view.trailingAnchor, constant: -30).isActive = true
        
        
        viewContainerStackHoursAndRating.topAnchor.constraint(equalTo: self.labelDescription.bottomAnchor, constant: 10).isActive = true
        viewContainerStackHoursAndRating.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -40).isActive = true
        viewContainerStackHoursAndRating.heightAnchor.constraint(equalToConstant: 50).isActive = true
        viewContainerStackHoursAndRating.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        stackViewHoursAndRating.topAnchor.constraint(equalTo: self.viewContainerStackHoursAndRating.topAnchor).isActive = true
        stackViewHoursAndRating.bottomAnchor.constraint(equalTo: self.viewContainerStackHoursAndRating.bottomAnchor).isActive = true
        stackViewHoursAndRating.leadingAnchor.constraint(equalTo: self.viewContainerStackHoursAndRating.leadingAnchor).isActive = true
        stackViewHoursAndRating.trailingAnchor.constraint(equalTo: self.viewContainerStackHoursAndRating.trailingAnchor).isActive = true
                
        labelHours.centerXAnchor.constraint(equalTo: self.viewContainerHours.centerXAnchor).isActive = true
        labelHours.centerYAnchor.constraint(equalTo: self.viewContainerHours.centerYAnchor).isActive = true

//        labelRating.centerXAnchor.constraint(equalTo: self.viewContainerRating.centerXAnchor).isActive = true
//        labelRating.centerYAnchor.constraint(equalTo: self.viewContainerRating.centerYAnchor).isActive = true

        viewBachground.anchor(top: self.view.topAnchor,
                              paddingTop: 0,
                              bottom: self.view.bottomAnchor,
                              paddingBottom: 0,
                              left: self.view.leadingAnchor,
                              paddingLeft: 0,
                              right: self.view.trailingAnchor,
                              paddingRight: 0,
                              width: 0,
                              height: 0)

        viewBachgroundRestaurant.anchor(top: self.view.safeAreaLayoutGuide.topAnchor,
                              paddingTop: 5,
                              bottom: self.viewContainerStackHoursAndRating.bottomAnchor,
                              paddingBottom: 5,
                              left: self.view.leadingAnchor,
                              paddingLeft: 15,
                              right: self.view.trailingAnchor,
                              paddingRight: -15,
                              width: 0,
                              height: 0)


        var views: [UIView] = []
        for _ in 0..<5 {
            let circle = UIView()
            circle.backgroundColor = .lightGray
            circle.layer.cornerRadius = 8
            circle.translatesAutoresizingMaskIntoConstraints = false
            circle.widthAnchor.constraint(equalToConstant: 15).isActive = true
            circle.heightAnchor.constraint(equalToConstant: 15).isActive = true
            views.append(circle)
        }

        switch (rating / 2) {
        case 0:
            ()
        case 1:
            views[0].backgroundColor = Colors.background
        case 2:
            views[0].backgroundColor = Colors.background
            views[1].backgroundColor = Colors.background
        case 3:
            views[0].backgroundColor = Colors.background
            views[1].backgroundColor = Colors.background
            views[2].backgroundColor = Colors.background
        case 4:
            views[0].backgroundColor = Colors.background
            views[1].backgroundColor = Colors.background
            views[2].backgroundColor = Colors.background
            views[3].backgroundColor = Colors.background
        default: //5
            views[0].backgroundColor = Colors.background
            views[1].backgroundColor = Colors.background
            views[2].backgroundColor = Colors.background
            views[3].backgroundColor = Colors.background
            views[4].backgroundColor = Colors.background
        }
        
        stackViewRatingCircles.centerXAnchor.constraint(equalTo: viewContainerRating.centerXAnchor).isActive = true
        stackViewRatingCircles.centerYAnchor.constraint(equalTo: viewContainerRating.centerYAnchor).isActive = true
        
        for item in 0..<views.count {
            views[item].widthAnchor.constraint(equalToConstant: 15).isActive = true
            views[item].heightAnchor.constraint(equalToConstant: 15).isActive = true
            stackViewRatingCircles.addArrangedSubview(views[item])
        }
        
    }
}
