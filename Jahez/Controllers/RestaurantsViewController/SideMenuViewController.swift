//
//  SideMenuViewController.swift
//  Jahez
//
//  Created by iOS Developer on 07/03/2022.
//

import UIKit

class SideMenuViewController: UIViewController {
    
    weak var delegate: FilterSectionDelegate? = nil
    var collectionView: UICollectionView!
    var tableView: UITableView! =  {
        let table = UITableView()
        
        table.translatesAutoresizingMaskIntoConstraints = false
        table.rowHeight = 470
        table.layer.backgroundColor = UIColor.white.cgColor
        table.tableFooterView = UIView(frame: .zero)
        return table
     }()

    var menuSections: [MenuSection]! = []

    enum TypeMenu {
        case menu
        case filter
    }
    
    static var type: TypeMenu = .filter
    var widthViewContainerConstraint: NSLayoutConstraint!
    var changeWidthViewConstraint: Bool = false
    var viewContainerMinu: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        if #available(iOS 11.0, *) {
            view.layer.maskedCorners = SideMenuViewController.type == .menu ? [.layerMaxXMaxYCorner, .layerMaxXMinYCorner] : [.layerMinXMaxYCorner, .layerMinXMinYCorner]////, .layerMaxXMaxYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        } else {
            view.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 20)
        }

        view.translatesAutoresizingMaskIntoConstraints = false
        view.slideInFromLeft()
        return view
    }()
    
    var viewHeaderMenu: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        if #available(iOS 11.0, *) {
            view.layer.maskedCorners = SideMenuViewController.type == .menu ? [.layerMaxXMaxYCorner, .layerMaxXMinYCorner] : [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        } else {
            view.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 20)
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        view.slideInFromLeft()
        view.alpha = 0
        return view
    }()
    
    var labelName: UILabel! = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.slideInFromLeft()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = Colors.background
        switch User.userIsLoggedIn {
        case true:
            label.text = "Welcome \(User.name.isEmpty ? "Ahmad" : User.name)"
        case false:
            label.text = "Welcome to Jahez!"
        }
        return label
    }()
       
    var labelBalance: UILabel! = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.slideInFromLeft()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = Colors.background
        switch User.userIsLoggedIn {
        case true:
            label.text = "Current Balance: \(User.balance.isEmpty ? "0.0" : User.balance) SAR"
        case false:
            label.text = ""
        }
        return label
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
            self.viewContainerMinu.frame.origin.x = SideMenuViewController.type == .filter ? self.view.frame.width : (-self.view.frame.width / 2)
            self.dismiss(animated: true, completion: nil)
        })

    }
    

}

//MARK: - LifeCycle:
extension SideMenuViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.view.backgroundColor = UIColor(white: 0, alpha: 0.4)
//        self.setupSideMenuViews()
        self.initData()

    }
    
    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupSideMenuViews()
    }
    
    override func viewDidLayoutSubviews() {
        buttonDismiss.frame = self.view.frame
    }
    
    override func viewWillLayoutSubviews() {
    }
    
}

//MARK: - Init Data
extension SideMenuViewController {
    func initData() {
        switch  SideMenuViewController.type {
        case .filter:
            menuSections = [MenuSection(name: "distance", imageName: "distance", index: 0, isSelected: true),
                           MenuSection(name: "rating", imageName: "rating", index: 1, isSelected: true),
                           MenuSection(name: "offers", imageName: "offer", index: 2, isSelected: true)]
        default:
            
            switch User.userIsLoggedIn {
            case true:
                menuSections = [MenuSection(name: "Payments", imageName: "distance", index: 0, isSelected: true),
                                MenuSection(name: "My Orders", imageName: "distance", index: 1, isSelected: true),
                                MenuSection(name: "Notifications", imageName: "distance", index: 2, isSelected: true),
                                MenuSection(name: "Alexa", imageName: "distance", index: 3, isSelected: true),
                                MenuSection(name: "Contact Us", imageName: "distance", index: 4, isSelected: true),
                                MenuSection(name: "About Jahez", imageName: "distance", index: 4, isSelected: true),
                                MenuSection(name: "Privacy Policy", imageName: "distance", index: 4, isSelected: true),
                                MenuSection(name: "Shared Jahez", imageName: "distance", index: 4, isSelected: true),
                                MenuSection(name: "Sign out", imageName: "distance", index: 4, isSelected: true),
                                MenuSection(name: "عربي", imageName: "distance", index: 4, isSelected: true)]

            case false:
                menuSections = [MenuSection(name: "Sign in", imageName: "distance", index: 0, isSelected: true),
                                MenuSection(name: "Contact Us", imageName: "distance", index: 1, isSelected: true),
                                MenuSection(name: "About Jahez", imageName: "distance", index: 2, isSelected: true),
                                MenuSection(name: "Privacy Policy", imageName: "distance", index: 3, isSelected: true),
                                MenuSection(name: "عربي", imageName: "distance", index: 4, isSelected: true)]
            }
        }
    }
}

//MARK: - Setup views
extension SideMenuViewController {
    
    func setupSideMenuViews() {
        self.view.addSubview(buttonDismiss)
        switch SideMenuViewController.type {
        case .filter:
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

        case .menu:

            self.view.addSubview(viewContainerMinu)
            viewContainerMinu.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 90).isActive = true
            viewContainerMinu.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -180).isActive = true
            widthViewContainerConstraint = viewContainerMinu.widthAnchor.constraint(equalToConstant: self.view.frame.width / 2)
            widthViewContainerConstraint.isActive = true
            viewContainerMinu.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
            
            self.viewContainerMinu.addSubview(tableView)
            tableView.topAnchor.constraint(equalTo: self.viewContainerMinu.topAnchor, constant: 50).isActive = true
            tableView.bottomAnchor.constraint(equalTo: self.viewContainerMinu.bottomAnchor).isActive = true
            tableView.widthAnchor.constraint(equalTo: self.viewContainerMinu.widthAnchor).isActive = true
            tableView.leadingAnchor.constraint(equalTo: self.viewContainerMinu.leadingAnchor).isActive = true
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
            tableView.dataSource = self
            tableView.delegate = self
            tableView.reloadData()
            
            self.viewContainerMinu.addSubview(self.labelName)
            self.labelName.leadingAnchor.constraint(equalTo: self.viewContainerMinu.leadingAnchor, constant: 20).isActive = true
            self.labelName.topAnchor.constraint(equalTo: self.viewContainerMinu.topAnchor, constant: 5).isActive = true
            self.labelName.heightAnchor.constraint(equalToConstant: 30).isActive = true
            self.labelName.widthAnchor.constraint(equalTo: self.viewContainerMinu.widthAnchor, constant: -14).isActive = true
            
            self.viewContainerMinu.addSubview(self.viewHeaderMenu)
            self.labelName.leadingAnchor.constraint(equalTo: self.viewContainerMinu.leadingAnchor, constant: 20).isActive = true
            self.labelName.topAnchor.constraint(equalTo: self.viewContainerMinu.topAnchor, constant: 0).isActive = true
            self.labelName.heightAnchor.constraint(equalToConstant: 30).isActive = true
            self.labelName.widthAnchor.constraint(equalTo: self.viewContainerMinu.widthAnchor, constant: -14).isActive = true
            
            self.viewContainerMinu.slideInFromLeft()
            self.tableView.slideInFromLeft()

        }
    }
}

//MARK: - UICollectionView Delegate, DataSource, FlowLayout
extension SideMenuViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func initCollectionView() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: self.viewContainerMinu.frame.width/2 - 10, height: self.viewContainerMinu.frame.width/2 - 10)
        collectionView = UICollectionView(frame: CGRect(x: 7, y: 5, width: self.viewContainerMinu.frame.width - 14, height: self.viewContainerMinu.frame.height - 10), collectionViewLayout: layout)
        collectionView.collectionViewLayout = layout
        collectionView.register(FilterOrOfferCollectionViewCell.self, forCellWithReuseIdentifier: "FilterOrOfferCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
        self.viewContainerMinu.addSubview(collectionView)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.menuSections.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterOrOfferCollectionViewCell", for: indexPath) as! FilterOrOfferCollectionViewCell
        cell.filterSection = menuSections[indexPath.row]
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemSize = collectionView.frame.width / 2 - 10
        return CGSize(width: itemSize, height:  itemSize)

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
        feedbackGenerator.impactOccurred()

        for item in 0..<self.menuSections.count {
            if item == indexPath.row {
                self.menuSections[indexPath.row].isSelected = true
            } else {
                self.menuSections[item].isSelected = false
            }
        }
        self.collectionView.reloadData()
        
        if let delegate = delegate {
            delegate.clickFilterSection(index: indexPath.row)
        }

    }
    
}
//MARK: - UITableView Delegates and DatasSouece
extension SideMenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuSections.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell : UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        }
        if self.menuSections.count > 0 {
            cell?.textLabel!.text = self.menuSections[indexPath.row].name
        }
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        cell?.textLabel?.textColor = Colors.background
        cell?.textLabel?.numberOfLines = 0
        cell?.imageView?.image = UIImage(named: self.menuSections[indexPath.row].imageName)?.imageWithImage(scaledToSize: CGSize(width: 30, height: 30))
        return cell!
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 50.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.changeWidthViewConstraint = true
            self.widthViewContainerConstraint.constant = User.userIsLoggedIn ? self.view.frame.width * 0.8 : 0
            UIView.animate(withDuration: 0.2, delay: 0, animations: {
                self.view.layoutIfNeeded()
            }) { complete in
                if complete {
                    switch User.userIsLoggedIn {
                    case true:
                        ()
                    case false:
                        //                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                        let loginView = LoginView()
                        loginView.closure = { [weak self] in
                            print("login")
                            UserDefaults.standard.setValue(true, forKey: "userIsLoggedIn")
                            User.userIsLoggedIn = true
                            self?.dismiss(animated: false, completion: nil)
                        }
                        self.view.addSubview(loginView)
                    }
                }
            }

        case 1:
            print("Contact Us")
            let tel = "tel://00966508437889"
            if let url = URL(string: tel) {
                 UIApplication.shared.open(url)
             }
        case 2:
            print("About Jahez")
            self.changeWidthViewConstraint = !self.changeWidthViewConstraint
            self.widthViewContainerConstraint.constant = self.changeWidthViewConstraint ? self.view.frame.width * 0.8 : self.view.frame.width * 0.5

            UIView.animate(withDuration: 0.2, delay: 0, animations: {
                self.view.layoutIfNeeded()
            })
            
        case 3:
            print("Privacy Policy")
            self.dismiss(animated: true, completion: {
                self.delegate?.clickMenuSection(index: indexPath.row)
                self.delegate = nil
            })
        case 4:
            print("عربي")
        case 5:
            print("About US")
        case 6:
            print("Privacy Policy")
        case 7:
            print("Share Jahez")
        case 8:
            print("Sign out")
            User.deleteAllData()
            self.initData()
            self.tableView.reloadData()
        default:
            print("change language")
        }
    }
    
}


