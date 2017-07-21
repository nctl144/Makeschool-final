//
//  MainTabBarViewController.swift
//  Green
//
//  Created by Nguyễn Lâm on 7/13/17.
//  Copyright © 2017 lam. All rights reserved.
//

import UIKit
import Material

class MainTabBarViewController: BottomNavigationController {
    let photoHelper = MGPhotoHelper()
    
    open override func prepare() {
        super.prepare()
        prepareTabBar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        
        photoHelper.completionHandler = { image in
            var flag = false
            let binaryImageData = TreeVerifier.base64EncodeImage(image)
            TreeVerifier.createRequest(with: binaryImageData, url: TreeVerifier.googleURL, completion: { (result) in
                print(result)
                
                if (result.contains("tree") || result.contains("woody plant") || result.contains("plant")) {
                    flag = true
                }
                
                if flag == true {
                    TreeService.createImageUrl(for: image)
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "upload"), object: self)
                }
                // if not a tree
                // create the alert
                DispatchQueue.main.async(execute: {
                    let alert = UIAlertController(title: "Take the picture again u dumbass", message: "Because it is NOT A FUCKING tree, its a dog", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK I am totally sorry", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                })
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func prepareTabBar() {
        tabBar.depthPreset = .none
        tabBar.dividerColor = Color.grey.lighten3
    }
}

//extension MainTabBarViewController: UITabBarControllerDelegate {
//    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//        if viewController.tabBarItem.tag == 3 {
//            // trigger the taking/choosing photo action
//            photoHelper.presentActionSheet(from: self)
//            return false
//        } else {
//            return true
//        }
//    }
//}
