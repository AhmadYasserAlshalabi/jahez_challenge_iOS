//
//  ItemDetailsViewController.swift
//  Jahez
//
//  Created by iOS Developer on 12/03/2022.
//

import UIKit

class ItemDetailsViewController: UIViewController {

    var closure: ((_ items: [ItemFood])->())? = nil
    
    var item: ItemFood! {
        didSet {
            self.labelPrice.text = item.price
            self.labelName.text = item.name
            self.labelDescription.text = item.description
            self.labelCount.text = item.count.description
            self.imageViewItem.image = UIImage(named: item.imageName)
        }
    }
    
    var viewContainerDetails: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var yAnchorContainerDetails: NSLayoutConstraint!
    
    var viewContainerImage: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.addShadow()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let imageViewItem: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
        imageView.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView

    }()

    let labelName: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
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

    let labelDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let labelCount: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var buttonPlus: UIView = {
        let button = UIButton()
        button.backgroundColor = Colors.background
        button.layer.cornerRadius = 15
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(buttonPlusAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var buttonMinus: UIView = {
        let button = UIButton()
        button.backgroundColor = .systemYellow
        button.layer.cornerRadius = 15
        button.setTitle("⁃", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(buttonMinusAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var buttonImageAddToCart: UIView = {
        let button = UIButton()
        button.backgroundColor = Colors.background
        button.layer.cornerRadius = 15
        button.setTitle("✔︎", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(buttonAddToCardAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var buttonAddToCart: UIView = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitleColor(Colors.background, for: .normal)
        button.setTitle("Add to card", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(buttonAddToCardAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var buttonDismiss: UIView = {
        let button = UIButton()
        button.backgroundColor = UIColor(white: 0, alpha: 0.2)
        button.addTarget(self, action: #selector(buttonDismissAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func buttonDismissAction() {
        UIView.animate(withDuration: 0.2, delay: 0, animations: {
            self.viewContainerDetails.frame.origin.y = (self.view.frame.height + self.view.frame.height * 0.3)
            self.dismiss(animated: true, completion: nil)
        })
    }
    
    @objc func buttonPlusAction() {
        item.count = item.count + 1
        self.labelCount.text = item.count.description
    }

    @objc func buttonMinusAction() {
        if item.count > 1 {
            item.count = item.count - 1
            self.labelCount.text = item.count.description
        }
    }
    
    @objc func buttonAddToCardAction() {
        if let closure = closure {
            var items: [ItemFood] = []
            for _ in 0..<item.count {
                items.append(item)
            }
            closure(items)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.setupViews()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        self.setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupViews()
    }
    
}

extension ItemDetailsViewController {
    
    func setupViews() {
//        buttonDismiss.frame = self.view.frame
        self.view.addSubview(buttonDismiss)


        self.buttonDismiss.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.buttonDismiss.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.buttonDismiss.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.buttonDismiss.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        self.view.addSubview(self.viewContainerDetails)
        self.viewContainerDetails.addSubview(self.viewContainerImage)
        
//        self.viewContainerDetails.backgroundColor = .blue
        self.viewContainerDetails.widthAnchor.constraint(equalToConstant: self.view.frame.width - 40).isActive = true
        self.viewContainerDetails.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.viewContainerDetails.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
//        self.viewContainerDetails.heightAnchor.constraint(equalTo: self.view.heightAnchor, constant: -400).isActive = true
        self.viewContainerDetails.heightAnchor.constraint(equalToConstant: 500).isActive = true
        
        self.viewContainerImage.topAnchor.constraint(equalTo: self.viewContainerDetails.topAnchor, constant: -40).isActive = true
        self.viewContainerImage.centerXAnchor.constraint(equalTo: self.viewContainerDetails.centerXAnchor).isActive = true
        self.viewContainerImage.widthAnchor.constraint(equalToConstant: 80).isActive = true
        self.viewContainerImage.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        self.viewContainerImage.addSubview(self.imageViewItem)
        
        self.imageViewItem.topAnchor.constraint(equalTo: self.viewContainerImage.topAnchor, constant: 0).isActive = true
        self.imageViewItem.centerXAnchor.constraint(equalTo: self.viewContainerImage.centerXAnchor).isActive = true
        self.imageViewItem.widthAnchor.constraint(equalTo: viewContainerImage.widthAnchor).isActive = true
        self.imageViewItem.heightAnchor.constraint(equalTo: viewContainerImage.heightAnchor).isActive = true

        self.viewContainerDetails.addSubview(self.labelPrice)
        
        self.labelPrice.topAnchor.constraint(equalTo: self.viewContainerDetails.topAnchor, constant: 10).isActive = true
        self.labelPrice.trailingAnchor.constraint(equalTo: self.viewContainerDetails.trailingAnchor, constant: -20).isActive = true

        self.viewContainerDetails.addSubview(self.labelName)
        
        self.labelName.topAnchor.constraint(equalTo: self.viewContainerImage.bottomAnchor, constant: 20).isActive = true
        self.labelName.trailingAnchor.constraint(equalTo: self.viewContainerDetails.trailingAnchor, constant: -20).isActive = true
        self.labelName.leadingAnchor.constraint(equalTo: self.viewContainerDetails.leadingAnchor, constant: 20).isActive = true

        self.viewContainerDetails.addSubview(self.labelDescription)
        
        self.labelDescription.topAnchor.constraint(equalTo: self.labelName.bottomAnchor, constant: 10).isActive = true
        self.labelDescription.trailingAnchor.constraint(equalTo: self.viewContainerDetails.trailingAnchor, constant: -20).isActive = true
        self.labelDescription.leadingAnchor.constraint(equalTo: self.viewContainerDetails.leadingAnchor, constant: 20).isActive = true
        
        self.viewContainerDetails.addSubview(self.buttonMinus)
        self.viewContainerDetails.addSubview(self.buttonPlus)
        self.viewContainerDetails.addSubview(self.labelCount)
        self.viewContainerDetails.addSubview(self.buttonImageAddToCart)
        self.viewContainerDetails.addSubview(self.buttonAddToCart)
        
        self.buttonMinus.bottomAnchor.constraint(equalTo: self.viewContainerDetails.bottomAnchor, constant: -20).isActive = true
        self.buttonMinus.leadingAnchor.constraint(equalTo: self.viewContainerDetails.leadingAnchor, constant: 20).isActive = true
        self.buttonMinus.widthAnchor.constraint(equalToConstant: 30).isActive = true
        self.buttonMinus.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.labelCount.leadingAnchor.constraint(equalTo: self.buttonMinus.trailingAnchor, constant: 15).isActive = true
        self.labelCount.centerYAnchor.constraint(equalTo: self.buttonMinus.centerYAnchor).isActive = true

        self.buttonPlus.bottomAnchor.constraint(equalTo: self.viewContainerDetails.bottomAnchor, constant: -20).isActive = true
        self.buttonPlus.leadingAnchor.constraint(equalTo: self.labelCount.trailingAnchor, constant: 15).isActive = true
        self.buttonPlus.widthAnchor.constraint(equalToConstant: 30).isActive = true
        self.buttonPlus.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.buttonImageAddToCart.bottomAnchor.constraint(equalTo: self.viewContainerDetails.bottomAnchor, constant: -20).isActive = true
        self.buttonImageAddToCart.trailingAnchor.constraint(equalTo: self.viewContainerDetails.trailingAnchor, constant: -20).isActive = true
        self.buttonImageAddToCart.widthAnchor.constraint(equalToConstant: 30).isActive = true
        self.buttonImageAddToCart.heightAnchor.constraint(equalToConstant: 30).isActive = true

        self.buttonAddToCart.trailingAnchor.constraint(equalTo: self.buttonImageAddToCart.leadingAnchor, constant: -5).isActive = true
        self.buttonAddToCart.centerYAnchor.constraint(equalTo: self.buttonMinus.centerYAnchor).isActive = true

        self.animateIn()
        
    }
}

//MARK: - Animations:
extension ItemDetailsViewController {
    func animateIn() {
        self.viewContainerDetails.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
        self.view.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut) {
            self.viewContainerDetails.transform = .identity
            self.view.alpha = 1
        }
    }
    
    func animateOut() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.viewContainerDetails.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
            self.view.alpha = 9
        }) { complete in
            if complete {
                
            }
        }

    }
}
