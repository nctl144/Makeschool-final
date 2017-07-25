//
//  AppDelegate.swift
//  Green
//
//  Created by Nguyễn Lâm on 7/11/17.
//  Copyright © 2017 lam. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit
import FacebookLogin
import FacebookCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    public func application(_ application: UIApplication,  didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        configureIntitialRootViewController(for: window)
        
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    public func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        return FBSDKApplicationDelegate.sharedInstance().application(
            app,
            open: url as URL!,
            sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String,
            annotation: options[UIApplicationOpenURLOptionsKey.annotation]
        )
    }
    
    public func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(
            application,
            open: url as URL!,
            sourceApplication: sourceApplication,
            annotation: annotation)
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask(rawValue: UIInterfaceOrientationMask.portrait.rawValue)
    }
}

// determine if the userdefault has been set, if yes then change the view to main immediately
extension AppDelegate {
    func configureIntitialRootViewController(for window: UIWindow?) {
        let initialViewController: UIViewController
        
        // skip the login flow if the currentuser has been set, firuser has been set
//        if Auth.auth().currentUser != nil {
        
            let fabMenuController = AppFABMenuController(rootViewController: UIStoryboard.initialViewController(for: .main))
            let toolBarController = AppToolbarController(rootViewController: fabMenuController)

            initialViewController = AppNavigationDrawerController(rootViewController: toolBarController, leftViewController: LeftViewController())

//        } else {
//            initialViewController = UIStoryboard.initialViewController(for: .login)
//        }
        
        window?.rootViewController = initialViewController
        window?.makeKeyAndVisible()
    }
}


