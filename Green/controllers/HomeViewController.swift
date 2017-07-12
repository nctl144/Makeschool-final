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

class HomeViewController: UIViewController {
    let myLoginButton = UIButton(type: .custom)
    let logOutButton = UIButton(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myLoginButton.backgroundColor = UIColor.darkGray
        myLoginButton.frame = CGRect(x: 0, y: 0, width: 180, height: 40);
        myLoginButton.center = view.center;
        myLoginButton.setTitle("Start Planting!", for: .normal)
        
        logOutButton.backgroundColor = UIColor.darkGray
        logOutButton.frame = CGRect(x: 0, y: 0, width: 180, height: 40);
        logOutButton.center = view.center;
        logOutButton.setTitle("log out", for: .normal)
        
        myLoginButton.alpha = 0
        logOutButton.alpha = 0
        
        logOutButton.addTarget(self, action: #selector(self.logOutButtonTapped), for: .touchUpInside)
        myLoginButton.addTarget(self, action: #selector(self.loginButtonClicked), for: .touchUpInside)
        
        // Handle clicks on the button
        if let accessToken = AccessToken.current {
            print("logged in")
            print(accessToken)
            // show the log out button if the user access token has existed
            self.logOutButton.alpha = 1
        } else {
            print("logged out")
            
            // show the login button if the access token is not set
            myLoginButton.alpha = 1
        }
        
        // Add the button to the view
        view.addSubview(myLoginButton)
        view.addSubview(logOutButton)
    }
    
    @objc func loginButtonClicked() {
        let loginManager = LoginManager()
        loginManager.logIn([ .publicProfile ], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                // hide the login button and show the logout button
                self.logOutButton.alpha = 1
                self.myLoginButton.alpha = 0
                
                print("Logged in!")
                print(grantedPermissions)
                print(accessToken)
            }
        }
    }
    
    @objc func logOutButtonTapped() {
        print("logging the user out")
        let loginManager = LoginManager()
        
        // log the user out
        loginManager.logOut()
        self.logOutButton.alpha = 0
        self.myLoginButton.alpha = 1
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
