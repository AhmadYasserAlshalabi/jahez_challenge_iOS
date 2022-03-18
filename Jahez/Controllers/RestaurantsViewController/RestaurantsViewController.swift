//
//  RestaurantsViewController.swift
//  Jahez
//
//  Created by iOS Developer on 04/03/2022.
//

import UIKit

class RestaurantsViewController: UIViewController {

    //Array of all restaurants list
    var restaurants: [Restaurant] = []
    
    //Array for filtering restaurants when search
    var searchRestaurants: [Restaurant] = []
    var isSearching: Bool = false
    
    //Array for list of offers
    var offers: [Offer] = [
        Offer(name: "1", image: "1"),
        Offer(name: "2", image: "2"),
        Offer(name: "3", image: "3")
    ]

    //CollectionView for list of restaurants
    var collectionView: UICollectionView! = {
        let collection =  UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.layer.backgroundColor = UIColor.white.cgColor
        return collection
     }()

    //SearchBar for search restaurant
    var searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "What are you looking..."
        searchBar.tintColor = .white
        searchBar.barTintColor = .white
        searchBar.barStyle = .default
        searchBar.sizeToFit()
        return searchBar
    }()
    
    //CollectiontView for list of offers
    var topCollectionViewOffersConstraint: NSLayoutConstraint!
    var collectionViewOffers: UICollectionView!  =  {
        let collection =  UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.layer.backgroundColor = UIColor.white.cgColor
        return collection
     }()

    //Check show or hide list of offers
    var showDrowerOffers: Bool = false

    //Button for show or hide "drower" of offers
    var buttonDismissOffers: UIButton = {
        let button = UIButton()
        button.backgroundColor = Colors.background
        button.setTitle("Offers", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //Check if show offers's list details
    var isOffers: Bool = false
    
    //Index of offer is chossed from drower
    var indexOffer: Int = -1

    //Button for return from offer's details to list of all restaurants
    var buttonAllResturant: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("All List", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        button.setTitleColor(Colors.background, for: .normal)
        button.addTarget(self, action: #selector(showListOfAllRestaurants), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func showListOfAllRestaurants() {
        self.isOffers = false
        self.collectionView.reloadData()
    }
}

//MARK: - LifeCycle:
extension RestaurantsViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup views
        self.searchBar.delegate = self
        self.hideKeyboardWhenTappedAround()
        self.setUpNavigationBarLogoImage()        
        self.setuUIBarButtons()
        self.initCollectionView()
        self.initCollectionViewOffers()

        //Get data from server
        self.getRestaurantData { restaurants in
            self.restaurants = restaurants
            self.collectionView.reloadData()
            self.collectionViewOffers.reloadData()
        }

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
}

extension RestaurantsViewController {
    func setuUIBarButtons() {
        //Add Filter button
        var icon = UIImage(named: "filter")
        var iconSize = CGRect(origin: CGPoint.zero, size: CGSize(width: 20, height: 20))
        var iconButton = UIButton(frame: iconSize)
        iconButton.setBackgroundImage(icon, for: .normal)
        var barButton = UIBarButtonItem(customView: iconButton)
        iconButton.addTarget(self, action: #selector(onFilterButtonClicked), for: .touchUpInside)
        barButton.customView?.translatesAutoresizingMaskIntoConstraints = false
        barButton.customView?.heightAnchor.constraint(equalToConstant: 24).isActive = true
        barButton.customView?.widthAnchor.constraint(equalToConstant: 24).isActive = true

        //Add Map button
        var icon2 = UIImage(named: "pinMap")?.withTintColor(.white)
        var iconSize2 = CGRect(origin: CGPoint.zero, size: CGSize(width: 20, height: 20))
        var iconButton2 = UIButton(frame: iconSize2)
        iconButton2.setBackgroundImage(icon2, for: .normal)
        var barButton2 = UIBarButtonItem(customView: iconButton2)
        iconButton2.addTarget(self, action: #selector(showMap), for: .touchUpInside)
        barButton2.customView?.translatesAutoresizingMaskIntoConstraints = false
        barButton2.customView?.heightAnchor.constraint(equalToConstant: 24).isActive = true
        barButton2.customView?.widthAnchor.constraint(equalToConstant: 24).isActive = true
        navigationItem.setRightBarButtonItems([barButton, barButton2], animated: false)

        //Add Menu button
        icon = UIImage(named: "menu")
        iconSize = CGRect(origin: CGPoint.zero, size: CGSize(width: 20, height: 20))
        iconButton = UIButton(frame: iconSize)
        iconButton.setBackgroundImage(icon, for: .normal)
        barButton = UIBarButtonItem(customView: iconButton)
        iconButton.addTarget(self, action: #selector(onMenuButtonClicked), for: .touchUpInside)
        barButton.customView?.translatesAutoresizingMaskIntoConstraints = false
        barButton.customView?.heightAnchor.constraint(equalToConstant: 24).isActive = true
        barButton.customView?.widthAnchor.constraint(equalToConstant: 24).isActive = true

        //Add Search button
        icon2 = UIImage(named: "search")?.withTintColor(.white)
        iconSize2 = CGRect(origin: CGPoint.zero, size: CGSize(width: 20, height: 20))
        iconButton2 = UIButton(frame: iconSize2)
        iconButton2.setBackgroundImage(icon2, for: .normal)
        barButton2 = UIBarButtonItem(customView: iconButton2)
        iconButton2.addTarget(self, action: #selector(searchFromNavBar), for: .touchUpInside)
        barButton2.customView?.translatesAutoresizingMaskIntoConstraints = false
        barButton2.customView?.heightAnchor.constraint(equalToConstant: 24).isActive = true
        barButton2.customView?.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        navigationItem.setLeftBarButtonItems([barButton, barButton2], animated: false)
        
    }
}

//MARK: - UICollectionView Delegate, DataSource, FlowLayout
extension RestaurantsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func initCollectionView() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: self.view.frame.width, height: 100)
        
        collectionView.collectionViewLayout = layout
        
        self.view.addSubview(self.collectionView)
        collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 35).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        collectionView.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "FooterViewCV")
        collectionView.register(RestaurantCollectionViewCell_1.self, forCellWithReuseIdentifier: "RestaurantCollectionViewCell_1")
        collectionView.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerCellId")
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()

    }
    
    func initCollectionViewOffers() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: self.view.frame.width, height: 190)
        layout.scrollDirection = .horizontal
        
        collectionViewOffers.collectionViewLayout = layout

        self.view.addSubview(collectionViewOffers)
        topCollectionViewOffersConstraint = collectionViewOffers.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: -190)
        topCollectionViewOffersConstraint.isActive = true
        collectionViewOffers.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        collectionViewOffers.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        collectionViewOffers.heightAnchor.constraint(equalToConstant: 190).isActive = true
        collectionViewOffers.register(FilterOrOfferCollectionViewCell.self, forCellWithReuseIdentifier: "FilterOrOfferCollectionViewCell")
        collectionViewOffers.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerCellId")
        collectionViewOffers.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "FooterViewCV")
        collectionViewOffers.contentInsetAdjustmentBehavior = .always
        collectionViewOffers.delegate = self
        collectionViewOffers.dataSource = self
        collectionViewOffers.isPagingEnabled = true
        collectionViewOffers.showsHorizontalScrollIndicator = false
        collectionViewOffers.reloadData()
        
        self.view.addSubview(self.buttonDismissOffers)
        self.buttonDismissOffers.topAnchor.constraint(equalTo: self.collectionViewOffers.bottomAnchor).isActive = true
        self.buttonDismissOffers.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.buttonDismissOffers.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.buttonDismissOffers.heightAnchor.constraint(equalToConstant: 35).isActive = true
        self.buttonDismissOffers.addTarget(self, action: #selector(self.showOffers_), for: .touchUpInside)

    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        switch collectionView {
        case collectionViewOffers:
            return 2
        default:
            return 2
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case self.collectionViewOffers:
            switch section {
            case 0:
                return self.offers.count
            default:
                return 0
            }
        default:
            switch section {
            case 0:
                return 0
            default:
                switch isOffers {
                case true:
                    return 1
                case false:
                    switch isSearching {
                    case true:
                        return self.searchRestaurants.count
                    case false:
                        return self.restaurants.count
                    }
                }
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case self.collectionViewOffers:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterOrOfferCollectionViewCell", for: indexPath) as! FilterOrOfferCollectionViewCell
            cell.index = indexPath.row
            cell.offer = offers[indexPath.row]
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RestaurantCollectionViewCell_1", for: indexPath) as! RestaurantCollectionViewCell_1
            switch isOffers {
            case true:
                //MARK: - To Do
                //Need the data of offers from API
                cell.restaurant = restaurants[indexOffer]//offers[indexOffer]
            case false:
                switch isSearching {
                case true:
                    cell.restaurant = searchRestaurants[indexPath.row]
                case false:
                    cell.restaurant = restaurants[indexPath.row]
                }
            }
            return cell
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch collectionView {
        case collectionViewOffers:
            switch kind {
            case UICollectionView.elementKindSectionHeader:
                return UICollectionReusableView()
            case UICollectionView.elementKindSectionFooter:
                    let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FooterViewCV", for: indexPath)
                    return footerView
            default:
                    
                assert(false, "Unexpected element kind")
            }
        default:
            switch kind {
            case UICollectionView.elementKindSectionHeader:

                if indexPath.section == 1 {
                    let fakeView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "fakeHeader", for: indexPath)
                    return fakeView
                }
                
                switch isOffers {
                case true:
                    searchBar.removeFromSuperview()
                    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerCellId", for: indexPath)
                        header.addSubview(buttonAllResturant)
                    buttonAllResturant.translatesAutoresizingMaskIntoConstraints = false
                    buttonAllResturant.leftAnchor.constraint(equalTo: header.leftAnchor).isActive = true
                    buttonAllResturant.rightAnchor.constraint(equalTo: header.rightAnchor).isActive = true
                    buttonAllResturant.topAnchor.constraint(equalTo: header.topAnchor).isActive = true
                    buttonAllResturant.bottomAnchor.constraint(equalTo: header.bottomAnchor).isActive = true
                    return  header
                case   false:
                    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerCellId", for: indexPath)
                    buttonAllResturant.removeFromSuperview()
                    header.addSubview(searchBar)
                    searchBar.translatesAutoresizingMaskIntoConstraints = false
                    searchBar.leftAnchor.constraint(equalTo: header.leftAnchor).isActive = true
                    searchBar.rightAnchor.constraint(equalTo: header.rightAnchor).isActive = true
                    searchBar.topAnchor.constraint(equalTo: header.topAnchor).isActive = true
                    searchBar.bottomAnchor.constraint(equalTo: header.bottomAnchor).isActive = true
                    return header
                }


             case UICollectionView.elementKindSectionFooter:
                     let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FooterViewCV", for: indexPath)
                     return footerView
                     
              default:
                     assert(false, "Unexpected element kind")
             }

        }
        
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch collectionView {
        case collectionViewOffers:
            return CGSize(width: 0,height: 0)
        default:
            return section == 0 ? CGSize(width: collectionView.frame.width, height: 40) : CGSize(width: collectionView.frame.width, height: 0)

//            return CGSize(width: self.collectionView.frame.width, height: 40)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        switch collectionView {
        case collectionViewOffers:
            switch section {
            case 0:
                return CGSize(width: 0, height: 0)
            default:
                return CGSize(width: self.view.frame.width, height: 30)
            }
        default:
            return section == 0 ? CGSize(width: collectionView.frame.width, height: 0) : CGSize(width: collectionView.frame.width, height: 30)
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
        switch collectionView {
        case self.collectionViewOffers:
            self.isOffers = true
            self.showDrowerOffers = true
            self.showOffers_()
            self.indexOffer = indexPath.row
            self.collectionView.reloadData()
        default:
            self.showDrowerOffers = true
            self.showOffers_()
            let vc = RestaurantDetailsViewController()
            vc.restaurant = self.restaurants[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)

        }
        
    }
    
}

//MARK: - Searching delegate
extension RestaurantsViewController: UISearchBarDelegate {
    func searchText(text: String) {
        switch text.isEmpty {
        case true:
            self.isSearching = false
        case false:
            self.isSearching = true
            self.searchRestaurants = (self.restaurants.filter({
                $0.name.lowercased().prefix(text.count) == text.lowercased() ||
                $0.distance.description.prefix(text.count) == text.lowercased()
            }))
        }

        self.collectionView.reloadSections([1])
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText(text: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchText(text: searchBar.text ?? "")
    }

}


//MARK: - Filetring list of restaurants
extension RestaurantsViewController: FilterSectionDelegate {
    @objc func onFilterButtonClicked() {

        SideMenuViewController.type = .filter
        let vc = SideMenuViewController()
        vc.delegate = self
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
        
    }
    
    func clickFilterSection(index: Int) {
        switch index {
        case 0:
            self.restaurants = restaurants.sorted(by: { $0.distance < $1.distance })
        case 1:
            self.restaurants = restaurants.sorted(by: { $0.rating < $1.rating })
        default:
            self.restaurants = restaurants.sorted(by: { $0.offer < $1.offer })
        }
        self.collectionView.reloadData()
    }
}

//MARK: - Menu
extension RestaurantsViewController {
    @objc func onMenuButtonClicked() {

        SideMenuViewController.type = .menu
        let vc = SideMenuViewController()
        vc.delegate = self
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
        
    }
    
    func clickMenuSection(index: Int) {
        switch index {
        case 2:
            let vc = AboutJahezViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 3:
            let vc = AboutJahezViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            ()
        }
    }
}

//MARK: - Show Offers
extension RestaurantsViewController {
    @objc func showOffers_() {
        if collectionViewOffers != nil {
            self.showDrowerOffers = !self.showDrowerOffers
            self.topCollectionViewOffersConstraint.constant = self.showDrowerOffers ? 0 : -190
//            UIView.animate(withDuration: 0.1, delay: 0, animations: {
//                self.view.layoutIfNeeded()
//            })
        }
    }
}

//MARK: - Show Map
extension RestaurantsViewController {
    @objc func showMap() {
        
    }
}

//MARK: - Show Map
extension RestaurantsViewController {
    @objc func searchFromNavBar() {
        self.showDrowerOffers = true
        self.showOffers_()
        self.isOffers = false
        self.collectionView.reloadData()
        collectionView.setContentOffset(.zero, animated: false)
        self.searchBar.searchTextField.becomeFirstResponder()
    }
}
