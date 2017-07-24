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
import Material

class ProfileViewController: UIViewController {

    @IBOutlet weak var userInfoView: UIView!
    @IBOutlet weak var profilePicView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var rewards = [Reward]()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        preparePageTabBarItem()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        preparePageTabBarItem()
    }
    
    fileprivate func preparePageTabBarItem() {
        pageTabBarItem.title = "Profile"
        pageTabBarItem.titleColor = Color.blueGrey.base
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        
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
    
    func configureTableView() {
        // remove seperator for empty cells
        tableView.tableFooterView = UIView()
        // remove seperator from cells
        tableView.separatorStyle = .none
        
        // add pull to refresh
//        refreshControl.addTarget(self, action: #selector(reloadTimeline), for: .valueChanged)
//        tableView.addSubview(refreshControl)
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
        
        self.view.window?.rootViewController = UIStoryboard.initialViewController(for: .login)
        self.view.window?.makeKeyAndVisible()
    }
}

extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RewardCell", for: indexPath) as! RewardCell
        
        cell.rewardLabel?.text = "Section \(indexPath.section) Row \(indexPath.row)"
        print("dang chay r em e")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section)"
    }
}
