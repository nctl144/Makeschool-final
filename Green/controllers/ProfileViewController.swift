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
        prepareTabBarItem()
    }
    
    private func prepareTabBarItem() {
        tabBarItem.title = "Home"
        tabBarItem.image = Icon.home?.tint(with: Color.blueGrey.base)
        tabBarItem.selectedImage = Icon.home?.tint(with: Color.blue.base)
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
}

extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RewardCell", for: indexPath) as! RewardCell
        let achievementIndex = indexPath.row + 1
        let achievementDict = Reward.achievements["achievement\(achievementIndex)"]!
    
        cell.rewardImage.image = UIImage(named: achievementDict["image"]!)
        cell.rewardLabel?.text = achievementDict["title"]
        
        return cell
    }
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(80)
    }
}
