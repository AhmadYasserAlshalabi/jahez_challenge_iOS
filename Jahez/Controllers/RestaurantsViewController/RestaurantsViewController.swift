//
//  RestaurantsViewController.swift
//  Jahez
//
//  Created by iOS Developer on 04/03/2022.
//

import UIKit

class RestaurantsViewController: UIViewController {

    var restaurants: [Restaurant] = []
    var labelHome = UILabel()
    var collectionView: UICollectionView!
    var tableView: UITableView!

}

//MARK: - LifeCycle:
extension RestaurantsViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNavigationBarTitleImage()
//        self.title = "Jahez"
//        self.initTableView()
        self.initCollectionView()
        //Add Filter button
        let icon = UIImage(named: "filter")
        let iconSize = CGRect(origin: CGPoint.zero, size: CGSize(width: 20, height: 20))
        let iconButton = UIButton(frame: iconSize)
        iconButton.setBackgroundImage(icon, for: .normal)
        let barButton = UIBarButtonItem(customView: iconButton)
        iconButton.addTarget(self, action: #selector(onFilterButtonClicked), for: .touchUpInside)
        barButton.customView?.translatesAutoresizingMaskIntoConstraints = false
        barButton.customView?.heightAnchor.constraint(equalToConstant: 24).isActive = true
        barButton.customView?.widthAnchor.constraint(equalToConstant: 24).isActive = true
        self.navigationItem.rightBarButtonItem  = barButton

        //Get data from server
        self.getRestaurantData { restaurants in
            self.restaurants = restaurants
            self.initCollectionView()
//            self.initTableView()
        }

    }

}

//MARK: - UICollectionView Delegate, DataSource, FlowLayout
extension RestaurantsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func initCollectionView() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: self.view.frame.width, height: 100)
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.collectionViewLayout = layout
        collectionView.dataSource = self
        collectionView.register(RestaurantCollectionViewCell_1.self, forCellWithReuseIdentifier: "RestaurantCollectionViewCell_1")
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
        self.view.addSubview(collectionView)

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.restaurants.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RestaurantCollectionViewCell_1", for: indexPath) as! RestaurantCollectionViewCell_1

        cell.restaurant = restaurants[indexPath.row]
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
        
        let vc = RestaurantDetailsViewController()
        vc.restaurant = self.restaurants[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
}

//MARK: - Sorting list of restaurants
extension RestaurantsViewController: FilterSectionDelegate {
    @objc func onFilterButtonClicked() {
        
        let vc = FilterSideMenuViewController()
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
