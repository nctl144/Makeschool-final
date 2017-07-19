//
//  ProfileViewController.swift
//  Green
//
//  Created by Nguyễn Lâm on 7/12/17.
//  Copyright © 2017 lam. All rights reserved.
//

import UIKit
import Kingfisher
import FirebaseAuth
import FacebookCore
import FacebookLogin

class ProfileViewController: UIViewController {

    @IBOutlet weak var userInfoView: UIView!
    @IBOutlet weak var profilePicView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var logoutButton: UIStackView!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserProfile.getUserData { (result) in
            print(result)
            DispatchQueue.main.async {
                self.usernameLabel.text = result[1].uppercased()
                self.profilePicView.kf.setImage(with: URL(string: "https://graph.facebook.com/\(result[0])/picture?width=500&height=500"))
            }
        }
        
        // styling
        userInfoView.layer.borderWidth = 1
        userInfoView.layer.borderColor = UIColor(hexString: "f1efec").cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func logOutButtonTapped(_ sender: UIButton) {
        let loginManager = LoginManager()
        
        // log the user out
        loginManager.logOut()
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("error signing in \(signOutError)")
        }
        
        performSegue(withIdentifier: "toHomePage", sender: self)
    }
}
