//
//  FilterSideMenuViewController.swift
//  Jahez
//
//  Created by iOS Developer on 07/03/2022.
//

import UIKit

class FilterSideMenuViewController: UIViewController {
    
    weak var delegate: FilterSectionDelegate? = nil
    var collectionView: UICollectionView!
    var filterSections: [FilterSection] = []
    
    var viewContainerMinu: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var buttonDismiss: UIView = {
        let button = UIButton()
        button.backgroundColor = UIColor(white: 0, alpha: 0.2)
        button.addTarget(self, action: #selector(buttonDismissAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    @objc func buttonDismissAction() {
        self.delegate = nil
        UIView.animate(withDuration: 0.2, delay: 0, animations: {
            self.viewContainerMinu.frame.origin.x = self.view.frame.width
            self.dismiss(animated: true, completion: nil)
        })

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(white: 0, alpha: 0.4)
        
        filterSections = [FilterSection(name: "distance", imageName: "distance", index: 0, isSelected: true),
                          FilterSection(name: "rating", imageName: "rating", index: 1, isSelected: true),
                          FilterSection(name: "offers", imageName: "offer", index: 2, isSelected: true),
        ]
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
        
        self.setupSideMenuViews()
    }
    
}

extension FilterSideMenuViewController {
    
    func setupSideMenuViews() {
        self.view.addSubview(buttonDismiss)
        buttonDismiss.frame = self.view.frame
        viewContainerMinu.frame = CGRect(x: self.view.frame.width,
                                         y: 90,
                                         width: self.view.frame.width / 2,
                                         height: self.view.frame.height - 180)
        viewContainerMinu.roundCorners(corners: [.topLeft, .bottomLeft], radius: 20)
        
        initCollectionView()
        
        self.view.addSubview(self.viewContainerMinu)

        UIView.animate(withDuration: 0.2, delay: 0, animations: {
            self.viewContainerMinu.frame.origin.x = self.view.frame.width / 2
        })

    }
}

//MARK: - UICollectionView Delegate, DataSource, FlowLayout
extension FilterSideMenuViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func initCollectionView() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: self.viewContainerMinu.frame.width/2 - 10, height: self.viewContainerMinu.frame.width/2 - 10)
        
        collectionView = UICollectionView(frame: CGRect(x: 7, y: 5, width: self.viewContainerMinu.frame.width - 14, height: self.viewContainerMinu.frame.height - 10), collectionViewLayout: layout)
        collectionView.collectionViewLayout = layout
        collectionView.dataSource = self
        collectionView.register(FilterSectionCollectionViewCell.self, forCellWithReuseIdentifier: "FilterSectionCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
        
        
        self.viewContainerMinu.addSubview(collectionView)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.filterSections.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterSectionCollectionViewCell", for: indexPath) as! FilterSectionCollectionViewCell

        cell.filterSection = filterSections[indexPath.row]
        
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemSize = collectionView.frame.width / 2 - 10
        
        return CGSize(width: itemSize, height:  itemSize)

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
        feedbackGenerator.impactOccurred()

        for item in 0..<self.filterSections.count {
            if item == indexPath.row {
                self.filterSections[indexPath.row].isSelected = true
            } else {
                self.filterSections[item].isSelected = false
            }
        }
        self.collectionView.reloadData()
        
        if let delegate = delegate {
            delegate.clickFilterSection(index: indexPath.row)
        }

    }
    
}
