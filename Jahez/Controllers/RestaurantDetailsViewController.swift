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
    
    var sections: [SectionFoods] = []
    var sectionFoods: SectionFoods!
    var itemsCart: [ItemFood] = []
    
    var collectionViewSections: UICollectionView!
    var collectionViewItemsFood: UICollectionView!
    
    var viewBachground: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.backgroundColor = .white
//        view.addShadow()
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

    @objc func onFilterButtonClicked() {
        
    }
    
}

//MARK: - LifeCycle:
extension RestaurantDetailsViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNavigationBarLogoImage()
        self.view.backgroundColor = Colors.background
        self.cartButtonNavBar()
        self.setupViews(rating: Int(self.restaurant.rating)!)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
}

extension RestaurantDetailsViewController {
    func cartButtonNavBar() {
        let iconSize = CGRect(origin: CGPoint.zero, size: CGSize(width: 30, height: 30))
        let customView: UIView = UIView(frame: iconSize)
        let icon = UIImage(named: "cart")
        let iconButton = UIButton(frame: iconSize)
        iconButton.setBackgroundImage(icon, for: .normal)
        customView.addSubview(iconButton)
        let barButton = UIBarButtonItem(customView: customView)
        iconButton.addTarget(self, action: #selector(onFilterButtonClicked), for: .touchUpInside)
        barButton.customView?.translatesAutoresizingMaskIntoConstraints = false
        barButton.customView?.heightAnchor.constraint(equalToConstant: 30).isActive = true
        barButton.customView?.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        if itemsCart.count > 0 {
            let attachmentCount = UIButton(frame: CGRect(x: 20, y: 0, width: 20, height: 14))
            attachmentCount.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
            attachmentCount.layer.cornerRadius = 7
            attachmentCount.backgroundColor = .systemYellow
            attachmentCount.setTitle("\(self.itemsCart.count)", for: .normal)
            customView.addSubview(attachmentCount)
        } else {
            
        }
        
        self.navigationItem.setRightBarButton(barButton, animated: false)
        
        
        
        
    }
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

        viewBachground.anchor(top: self.view.topAnchor,
                              paddingTop: 0,
                              bottom: self.view.safeAreaLayoutGuide.bottomAnchor,
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
        
        initCollectionViewItemsFood()
        initCollectionViewSectinos()
    }
}

//MARK: - UICollectionView Delegate, DataSource, FlowLayout
extension RestaurantDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func initCollectionViewSectinos() {

        self.sections = [ SectionFoods(name: "All", id: 0, isSelected: true, itemsFoods: [ItemFood(name: "9 PCS DIPS BUCKET", imageName: "food1", id: 1, isSelected: false),
                                                                                          ItemFood(name: "BUCKET FOR 2", imageName: "food2", id: 2, isSelected: false),
                                                                                          ItemFood(name: "SUPER BUCKET 21 PCS MIX", imageName: "food3", id: 3, isSelected: false),
                                                                                          ItemFood(name: "SUPER BUCKET 15 PCS", imageName: "food4", id: 6, isSelected: false),
                                                                                          ItemFood(name: "TWISTER BLAZE BOX", imageName: "food5", id: 4, isSelected: false),
                                                                                          ItemFood(name: "ZENGER", imageName: "food6", id: 5, isSelected: false),
                                                                                          ItemFood(name: "Variety Meal", imageName: "food7", id: 6, isSelected: false),
                                                                                          ItemFood(name: "Variety Meal", imageName: "food7", id: 7, isSelected: false),
                                                                                          ItemFood(name: "Double Bucket", imageName: "food8", id: 8, isSelected: false),
                                                                                          ItemFood(name: "Pepper Onion Fries", imageName: "food9", id: 7, isSelected: false),
                                                                                          ItemFood(name: "CHOCOLATE CAKE", imageName: "food10", id: 8, isSelected: false),
                                                                                          ItemFood(name: "FRESH ORANGE JUICE", imageName: "food11", id: 9, isSelected: false),
                                                                                         ]),
                          SectionFoods(name: "DEALS", id: 1, isSelected: false, itemsFoods: [ItemFood(name: "9 PCS DIPS BUCKET", imageName: "food1", id: 1, isSelected: false),
                                                                                             ItemFood(name: "BUCKET FOR 2", imageName: "food2", id: 2, isSelected: false),
                                                                                             ItemFood(name: "SUPER BUCKET 21 PCS MIX", imageName: "food3", id: 3, isSelected: false),
                                                                                             ItemFood(name: "SUPER BUCKET 15 PCS", imageName: "food4", id: 6, isSelected: false),
                                                                                            ]),
                          SectionFoods(name: "FOR ONE", id: 2, isSelected: false, itemsFoods: [ItemFood(name: "TWISTER BLAZE BOX", imageName: "food5", id: 4, isSelected: false),
                                                                                               ItemFood(name: "ZENGER", imageName: "food6", id: 5, isSelected: false),
                                                                                                ]),
                          SectionFoods(name: "SHARING", id: 3, isSelected: false, itemsFoods: [ItemFood(name: "Variety Meal", imageName: "food7", id: 7, isSelected: false),
                                                                                               ItemFood(name: "Double Bucket", imageName: "food8", id: 8, isSelected: false),
                                                                                              ]),
                          SectionFoods(name: "DESSERTS", id: 3, isSelected: false, itemsFoods: [ItemFood(name: "Pepper Onion Fries", imageName: "food9", id: 7, isSelected: false),
                                                                                                 ItemFood(name: "CHOCOLATE CAKE", imageName: "food10", id: 8, isSelected: false),
                                                                                                 ItemFood(name: "FRESH ORANGE JUICE", imageName: "food11", id: 9, isSelected: false),
                                                                                                ]),
        ]
        
        sectionFoods = sections[0]
        
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: self.view.frame.width / 3.7, height: 50)
        collectionViewSections = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionViewSections.backgroundColor = .clear
        collectionViewSections.translatesAutoresizingMaskIntoConstraints = false
        collectionViewSections.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        view.addSubview(collectionViewSections)
        
        collectionViewSections.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        collectionViewSections.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionViewSections.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionViewSections.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        collectionViewSections.dataSource = self
        collectionViewSections.delegate = self

        collectionViewSections.collectionViewLayout = layout
        collectionViewSections.register(SectionFoodCollectionViewCell.self, forCellWithReuseIdentifier: "SectionFoodCollectionViewCell")
        collectionViewSections.contentInsetAdjustmentBehavior = .always
        collectionViewSections.backgroundColor = Colors.background
        collectionViewSections.isPagingEnabled = true
        collectionViewSections.showsHorizontalScrollIndicator = false

        collectionViewSections.reloadData()

    }

    func initCollectionViewItemsFood() {

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        collectionViewItemsFood = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionViewItemsFood.translatesAutoresizingMaskIntoConstraints = false
        collectionViewItemsFood.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: +40, right: 0)
        view.addSubview(collectionViewItemsFood)
        
        collectionViewItemsFood.topAnchor.constraint(equalTo: viewContainerStackHoursAndRating.safeAreaLayoutGuide.bottomAnchor, constant: 20).isActive = true
        collectionViewItemsFood.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionViewItemsFood.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionViewItemsFood.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true

        collectionViewItemsFood.collectionViewLayout = layout
        collectionViewItemsFood.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: "ItemCollectionViewCell")
        collectionViewItemsFood.contentInsetAdjustmentBehavior = .always
        collectionViewItemsFood.dataSource = self
        collectionViewItemsFood.delegate = self
        if let collectionViewLayout = collectionViewItemsFood.collectionViewLayout as? UICollectionViewFlowLayout {
           collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }

        collectionViewItemsFood.backgroundColor = .white
        collectionViewItemsFood.isPagingEnabled = true
        collectionViewItemsFood.showsHorizontalScrollIndicator = false

        collectionViewItemsFood.reloadData()

    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case collectionViewSections:
           return self.sections.count
        default:
           return self.sectionFoods.itemsFoods.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        switch collectionView {
        case collectionViewSections:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SectionFoodCollectionViewCell", for: indexPath) as! SectionFoodCollectionViewCell
            cell.section = self.sections[indexPath.row]
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as! ItemCollectionViewCell
            cell.item = self.sectionFoods.itemsFoods[indexPath.row]
            return cell
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
        
        switch collectionView {
        case collectionViewSections:
            self.sectionFoods = sections[indexPath.row]

            for item in 0..<self.sections.count {
                if indexPath.row == item {
                    self.sections[item].isSelected = true
                } else {
                    self.sections[item].isSelected = false
                }
            }
            
            self.collectionViewSections.reloadData()
            self.collectionViewItemsFood.reloadData()
        default:

            let vc = ItemDetailsViewController()
//            vc.delegate = self
            vc.item = self.sectionFoods.itemsFoods[indexPath.row]
            vc.closure = { [weak self] items in
                if let self = self {
                    for itr in 0..<items.count {
                        self.itemsCart.append(items[itr])
                    }
                    self.cartButtonNavBar()
                }
            }
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true, completion: nil)

        }
        
    }
    
}
