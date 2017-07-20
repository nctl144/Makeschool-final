//
//  HomeViewController.swift
//  Green
//
//  Created by Nguyễn Lâm on 7/11/17.
//  Copyright © 2017 lam. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin

import FirebaseAuth
import FirebaseCore
import Material

class HomeViewController: UIViewController {
    
    @IBOutlet weak var card: Card!
    @IBOutlet weak var toolbar: Toolbar!
    
    @IBOutlet weak var button: FlatButton!
    @IBOutlet weak var bottomBar: Bar!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var logoImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareBottomBar()
        prepareCard()
        prepareToolbar()
        
        self.view.addBackground(imageName: "another-background.jpg", contentMode: .scaleAspectFill)

        logoImage.image = UIImage(named: "icon.png")


        // Handle clicks on the button
        if AccessToken.current != nil {
            // show the log out button if the user access token has existed
            let credential = FacebookAuthProvider.credential(withAccessToken: (AccessToken.current?.authenticationToken)!)
            
            Auth.auth().signIn(with: credential) { (user, error) in
                print("User logged in the firebase")
                self.performSegue(withIdentifier: "toProfilePage", sender: self)
            }
        } else {
            // show the login button if the access token is not set
            do {
                try Auth.auth().signOut()
            } catch let signOutError as NSError {
                print("error signing in \(signOutError)")
            }
        }
    }

    @IBAction func loginButtonTapped(_ sender: UIButton) {
        let loginManager = LoginManager()
        loginManager.logIn([ .publicProfile ], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                let credential = FacebookAuthProvider.credential(withAccessToken: (AccessToken.current?.authenticationToken)!)
                
                Auth.auth().signIn(with: credential) { (user, error) in
                    print("User logged in the firebase")
                }
            }
            
            self.performSegue(withIdentifier: "toProfilePage", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension HomeViewController {
    fileprivate func prepareToolbar() {
//        toolbar = Toolbar(rightViews: [moreButton])
        
        toolbar.titleLabel.textAlignment = .left
        
        toolbar.detailLabel.textAlignment = .left
        toolbar.detailLabel.textColor = Color.grey.base
    }
    
    fileprivate func prepareBottomBar() {
        bottomBar.centerViews = [button]
    }
    
    fileprivate func prepareCard() {
        card.toolbar = toolbar
        card.contentView = contentView
        card.bottomBar = bottomBar
        
        card.toolbarEdgeInsetsPreset = .square3
        card.toolbarEdgeInsets.bottom = 0
        card.toolbarEdgeInsets.right = 8
        
        card.contentViewEdgeInsetsPreset = .wideRectangle3
        
        card.bottomBarEdgeInsetsPreset = .wideRectangle2
        
    }
}
