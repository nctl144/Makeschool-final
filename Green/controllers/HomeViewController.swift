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
    
    @IBOutlet weak var logoImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addBackground(imageName: "another-background.jpg", contentMode: .scaleAspectFill)

        logoImage.image = UIImage(named: "icon.png")


        // Handle clicks on the button
        if AccessToken.current != nil {
            let credential = FacebookAuthProvider.credential(withAccessToken: (AccessToken.current?.authenticationToken)!)
            
            Auth.auth().signIn(with: credential) { (user, error) in
                print("User logged in the firebase")
            }
        } else {
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
                    TransitionExtension.toHomePage(self.view.window)
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
