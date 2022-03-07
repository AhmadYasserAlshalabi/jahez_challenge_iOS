//
//  AppDelegate.swift
//  Jahez
//
//  Created by iOS Developer on 04/03/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        self.initNavigationBar()

        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = SplushViewController()
        let navController = UINavigationController(rootViewController: viewController)
        navController.isNavigationBarHidden = false
        navController.view.backgroundColor = Colors.background
        navController.setStatusBar(backgroundColor: Colors.background)
        window!.rootViewController = navController
        window!.makeKeyAndVisible()
        
        return true
    }
    
    func initNavigationBar() {
        UINavigationBar.appearance().backgroundColor = Colors.background
        UINavigationBar.appearance().barTintColor = Colors.background
        UIBarButtonItem.appearance().tintColor = .magenta
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        UITabBar.appearance().barTintColor = .yellow
        
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = Colors.background
            UINavigationBar.appearance().isTranslucent = true  // pass "true" for fixing iOS 15.0 black bg issue
            UINavigationBar.appearance().tintColor = Colors.background // We need to set tintcolor for iOS 15.0
            appearance.shadowColor = .clear    //removing navigationbar 1 px bottom border.
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }

    }
    
    func changeRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard let window = self.window else {
            return
        }
        let navController = UINavigationController(rootViewController: vc)
        navController.isNavigationBarHidden = false
        navController.view.backgroundColor = Colors.background
        navController.setStatusBar(backgroundColor: Colors.background)

        window.rootViewController = navController

    }

}
