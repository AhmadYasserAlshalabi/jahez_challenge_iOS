//
//  Extensions.swift
//  Jahez
//
//  Created by iOS Developer on 07/03/2022.
//

import Foundation
import UIKit

//MARK: - Set status bar background color
extension UINavigationController {

    func setStatusBar(backgroundColor: UIColor) {
        let statusBarFrame: CGRect
        if #available(iOS 13.0, *) {
            statusBarFrame = view.window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero
        } else {
            statusBarFrame = UIApplication.shared.statusBarFrame
        }
        let statusBarView = UIView(frame: statusBarFrame)
        statusBarView.backgroundColor = backgroundColor
        view.addSubview(statusBarView)
    }

}

//MARK: - Get NavigationBar Height
extension UIViewController{
   var navigationBarHeight: CGFloat {
       return self.navigationController?.navigationBar.frame.height ?? 0.0
   }
    
    func setUpNavigationBarLogoImage() {
        let navController = navigationController!
        let image = UIImage(named: "logo")!
        let imageView = UIImageView(image: image)
        let bannerHeight = navController.navigationBar.frame.size.height
        imageView.frame = CGRect(x: navController.navigationBar.frame.width / 2 - 10, y: 0, width: 100, height: bannerHeight)
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }

}

enum ConstraintEdge {
    case right
    case left
    case top
    case bottom
}

extension  UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
         let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         layer.mask = mask
     }

    
    func circlesView() {
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 2
        contentMode = .scaleAspectFill
        layer.cornerRadius = self.frame.height / 2
        layer.masksToBounds = false
        clipsToBounds = true
    }

    func anchor(top : NSLayoutYAxisAnchor? ,
                paddingTop : CGFloat,
                priorityTop: Float = 100,
                bottom : NSLayoutYAxisAnchor?,
                paddingBottom : CGFloat,
                priorityBottom: Float = 100,
                left: NSLayoutXAxisAnchor?,
                paddingLeft: CGFloat,
                priorityLeft: Float = 100,
                right: NSLayoutXAxisAnchor?,
                paddingRight: CGFloat,
                priorityRight: Float = 100,
                width: CGFloat,
                priorityWidth: Float = 100,
                height: CGFloat,
                priorityHeight: Float = 100){
        
        translatesAutoresizingMaskIntoConstraints = false
        var anchor: NSLayoutConstraint = NSLayoutConstraint()
        
        if let top = top {
            anchor = topAnchor.constraint(equalTo: top, constant: paddingTop)
//            anchor.priority = UILayoutPriority(priorityTop)
            anchor.isActive = true
        }
        
        if let bottom = bottom {
            anchor = bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom)
//            anchor.priority = UILayoutPriority(priorityBottom)
            anchor.isActive = true
        }
        
        if let left = left {
            anchor = leadingAnchor.constraint(equalTo: left, constant: paddingLeft)
            anchor.priority = UILayoutPriority(priorityLeft)
            anchor.isActive = true
        }
        
        if let right = right {
            anchor = trailingAnchor.constraint(equalTo: right, constant: paddingRight)
//            anchor.priority = UILayoutPriority(priorityRight)
            anchor.isActive = true
        }
        
        if  width != 0 {
            anchor = widthAnchor.constraint(equalToConstant: width)
//            anchor.priority = UILayoutPriority(priorityWidth)
            anchor.isActive = true
        }
        
        if  height != 0 {
            anchor = heightAnchor.constraint(equalToConstant: height)
//            anchor.priority = UILayoutPriority(priorityHeight)
            anchor.isActive = true
        }
    }
    
    func setSize(width : CGFloat,
                 priorityWidth: Float = 100,
                 height : CGFloat,
                 priorityHeight: Float = 100)  {
        
        translatesAutoresizingMaskIntoConstraints = false
        var anchor: NSLayoutConstraint = NSLayoutConstraint()

        if  width != 0 {
            anchor = widthAnchor.constraint(equalToConstant: width)
            anchor.priority = UILayoutPriority(priorityWidth)
            anchor.isActive = true
        }
        
        if  height != 0 {
            anchor = heightAnchor.constraint(equalToConstant: height)
            anchor.priority = UILayoutPriority(100)
            anchor.isActive = true
        }
    }
    
    
    func center(centerX: NSLayoutXAxisAnchor?,
                centerY: NSLayoutYAxisAnchor?)  {
        
        self.center(centerX: centerX, paddingX: 0, centerY: centerY, paddingY: 0)
        
    }
    
    func center(centerX: NSLayoutXAxisAnchor?,
                paddingX: CGFloat,
                centerY: NSLayoutYAxisAnchor?,
                paddingY: CGFloat)  {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let centerX = centerX {
            centerXAnchor.constraint(equalTo: centerX , constant: paddingX).isActive = true
        }
        
        if let centerY = centerY {
            centerYAnchor.constraint(equalTo: centerY , constant: paddingY).isActive = true
        }
    }
    
    func addHConstraint(const: NSLayoutXAxisAnchor?,
                        edgeConst : ConstraintEdge,
                        padding: CGFloat = 0) -> NSLayoutConstraint?{
        
        if let edge = const, edgeConst == .right {
            let actualConst =   trailingAnchor.constraint(equalTo: edge, constant: padding)
            actualConst.isActive = true
            return actualConst
        }
        
        else if let edge = const , edgeConst == .left   {
            let actualConst =  leadingAnchor.constraint(equalTo: edge, constant: padding)
            actualConst.isActive = true
            return actualConst
            
        }
        return nil
    }
    
    func addVConstraint(const: NSLayoutYAxisAnchor?, edgeConst : ConstraintEdge ,  padding: CGFloat = 0 ) -> NSLayoutConstraint?{
        
        if let edge = const , edgeConst == .top   {
            let actualConst =  topAnchor.constraint(equalTo: edge, constant: padding)
            actualConst.isActive = true
            return actualConst
            
        }
        
        else if let edge = const , edgeConst == .bottom   {
            let actualConst =  bottomAnchor.constraint(equalTo: edge, constant: padding)
            actualConst.isActive = true
            return actualConst
            
        }
        return nil
    }
}

extension UIImage {
    var noir: UIImage? {
        let context = CIContext(options: nil)
        guard let currentFilter = CIFilter(name: "CIPhotoEffectNoir") else { return nil }
        currentFilter.setValue(CIImage(image: self), forKey: kCIInputImageKey)
        if let output = currentFilter.outputImage,
            let cgImage = context.createCGImage(output, from: output.extent) {
            return UIImage(cgImage: cgImage, scale: scale, orientation: imageOrientation)
        }
        return nil
    }
    
    func imageWithImage(scaledToSize newSize: CGSize) -> UIImage {
        
        UIGraphicsBeginImageContext(newSize)
        self.draw(in: CGRect(x: 0 ,y: 0 ,width: newSize.width ,height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!.withRenderingMode(.alwaysOriginal)
    }
}

extension UIView {
    
    func addShadow(){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 5.0
    }
    
    func underlineShadow() {
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 2, height: 4)
        self.layer.shadowRadius = 5
    }
    func slideInFromLeft(duration: TimeInterval = 0.3, completionDelegate: AnyObject? = nil) {
        // Create a CATransition animation
        let slideInFromLeftTransition = CATransition()

        // Customize the animation's properties
        slideInFromLeftTransition.type = CATransitionType.push
        slideInFromLeftTransition.subtype = CATransitionSubtype.fromLeft
        slideInFromLeftTransition.duration = duration
        slideInFromLeftTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        slideInFromLeftTransition.fillMode = CAMediaTimingFillMode.removed

        // Add the animation to the View's layer
        self.layer.add(slideInFromLeftTransition, forKey: "slideInFromLeftTransition")
    }

}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}











