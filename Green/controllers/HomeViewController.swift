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

class HomeViewController: UIViewController {
    
    @IBOutlet weak var myLoginButton: UIButton!
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var gotoProfileButton: UIButton!
    @IBOutlet weak var iconImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // self.view.addBackground(imageName: "background4.png", contentMode: .scaleAspectFill)
        
        iconImageView.image = UIImage(named: "icon.png")
        
        myLoginButton.setTitle("Start Planting!", for: .normal)
        logOutButton.setTitle("log out", for: .normal)
        
        // Handle clicks on the button
        if AccessToken.current != nil {
            // show the log out button if the user access token has existed
            let credential = FacebookAuthProvider.credential(withAccessToken: (AccessToken.current?.authenticationToken)!)
            
            Auth.auth().signIn(with: credential) { (user, error) in
                print("User logged in the firebase")
                self.performSegue(withIdentifier: "toProfilePage", sender: self)
            }
            self.logOutButton.isHidden = false
        } else {
            // show the login button if the access token is not set
            do {
                try Auth.auth().signOut()
            } catch let signOutError as NSError {
                print("error signing in \(signOutError)")
            }
            myLoginButton.isHidden = false
        }
        
        // Add the button to the view
        view.addSubview(myLoginButton)
        view.addSubview(logOutButton)
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
                
                // hide the login button and show the logout button
                self.logOutButton.isHidden = false
                self.myLoginButton.isHidden = true
            }
            
            self.performSegue(withIdentifier: "toProfilePage", sender: self)
        }
    }
    
    @IBAction func logOutButtonTapped(_ sender: UIButton) {
        print("logging the user out")
        let loginManager = LoginManager()
        
        // log the user out
        loginManager.logOut()
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("error signing in \(signOutError)")
        }
        self.logOutButton.isHidden = true
        self.myLoginButton.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIView {
    func addBackground(imageName: String, contentMode: UIViewContentMode) {
        let imageViewBackground = UIImageView()
        imageViewBackground.image = UIImage(named: imageName)
        
        // you can change the content mode:
        imageViewBackground.contentMode = contentMode
        imageViewBackground.clipsToBounds = true
        imageViewBackground.translatesAutoresizingMaskIntoConstraints = false
        
        self.insertSubview(imageViewBackground, at: 0)
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|[imageViewBackground]|",
                                                           options: [],
                                                           metrics: nil,
                                                           views: ["imageViewBackground": imageViewBackground]))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[imageViewBackground]|",
                                                           options: [],
                                                           metrics: nil,
                                                           views: ["imageViewBackground": imageViewBackground]))
    }
}

