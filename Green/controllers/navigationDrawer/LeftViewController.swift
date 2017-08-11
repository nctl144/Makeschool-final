//
//  LeftViewController.swift
//  Green
//
//  Created by Nguyễn Lâm on 7/24/17.
//  Copyright © 2017 lam. All rights reserved.
//

import UIKit
import FirebaseAuth
import FacebookCore
import FacebookLogin
import Material

class LeftViewController: UIViewController {
    fileprivate var transitionButton: FlatButton!
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hexString: "37505C")
        
        prepareTransitionButton()
        prepareLogoutButton()
    }
}

extension LeftViewController {
    fileprivate func prepareTransitionButton() {
        transitionButton = FlatButton(title: "Credits", titleColor: .white)
        transitionButton.backgroundColor = UIColor(hexString: "912F56")
        transitionButton.contentHorizontalAlignment = .left
        transitionButton.contentEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        transitionButton.pulseColor = .white
        transitionButton.addTarget(self, action: #selector(handleTransitionButton), for: .touchUpInside)
        
        view.layout(transitionButton).horizontally().top()
    }
    
    fileprivate func prepareLogoutButton() {
        transitionButton = FlatButton(title: "Log out", titleColor: .white)
        transitionButton.backgroundColor = UIColor(hexString: "F76F8E")
        transitionButton.contentHorizontalAlignment = .left
        transitionButton.contentEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        transitionButton.pulseColor = .white
        transitionButton.addTarget(self, action: #selector(handleLogOutButton), for: .touchUpInside)
        
        view.layout(transitionButton).horizontally().top(61)
    }
}

extension LeftViewController {
    @objc
    fileprivate func handleTransitionButton() {
        let initialViewController: UIViewController
        initialViewController = UIStoryboard.initialViewController(for: .credit)
        
        (navigationDrawerController?.rootViewController as? ToolbarController)?.transition(to: initialViewController, completion: closeNavigationDrawer)
    }
    
    @objc
    fileprivate func handleLogOutButton() {
        let loginManager = LoginManager()
        
        // log the user out
        loginManager.logOut()

        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("error signing in \(signOutError)")
        }
        
        self.view.window?.rootViewController = UIStoryboard.initialViewController(for: .login)
        self.view.window?.makeKeyAndVisible()
    }
    
    fileprivate func closeNavigationDrawer(result: Bool) {
        navigationDrawerController?.closeLeftView()
    }
}
