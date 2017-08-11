//
//  TransitionExtension.swift
//  Green
//
//  Created by Nguyễn Lâm on 8/11/17.
//  Copyright © 2017 lam. All rights reserved.
//

import UIKit
import Material
import FirebaseAuth
import FacebookLogin

struct TransitionExtension {
    static func toHomePage(_ window: UIWindow?) {
        let initialViewController: UIViewController
        let fabMenuController = AppFABMenuController(rootViewController: UIStoryboard.initialViewController(for: .main))
        let toolBarController = AppToolbarController(rootViewController: fabMenuController)
        let snackbarController = AppSnackbarController(rootViewController: toolBarController)
        
        initialViewController = AppNavigationDrawerController(rootViewController: snackbarController, leftViewController: LeftViewController())
        
        window?.rootViewController = initialViewController
        window?.makeKeyAndVisible()
    }
    
    static func toLoginPage(_ window: UIWindow?) {
        let loginManager = LoginManager()
        
        // log the user out
        loginManager.logOut()
        
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("error signing in \(signOutError)")
        }
        
        window?.rootViewController = UIStoryboard.initialViewController(for: .login)
        window?.makeKeyAndVisible()
    }
    
    static func toCreditPage(_ window: UIWindow?) {
        
        let initialViewController: UIViewController
        let toolBarController = AppToolbarController(rootViewController: UIStoryboard.initialViewController(for: .credit))
        let snackbarController = AppSnackbarController(rootViewController: toolBarController)
        
        initialViewController = AppNavigationDrawerController(rootViewController: snackbarController, leftViewController: LeftViewController())
        
        window?.rootViewController = initialViewController
        window?.makeKeyAndVisible()
    }
}
