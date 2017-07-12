//
//  ProfileViewController.swift
//  Green
//
//  Created by Nguyễn Lâm on 7/12/17.
//  Copyright © 2017 lam. All rights reserved.
//

import UIKit
import Kingfisher

class ProfileViewController: UIViewController {

    @IBOutlet weak var profilePicView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserProfile.getUserData { (result) in
            print(result)
            DispatchQueue.main.async {
                self.usernameLabel.text = result[1]
                self.profilePicView.kf.setImage(with: URL(string: "https://graph.facebook.com/\(result[0])/picture?type=large"))
            }
        }
        
        // styling
        profilePicView.layer.cornerRadius = profilePicView.frame.height/3
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
