//
//  AppPageTabBarController.swift
//  Green
//
//  Created by Nguyễn Lâm on 7/24/17.
//  Copyright © 2017 lam. All rights reserved.
//

import UIKit
import Material

class AppPageTabBarController: PageTabBarController {
    open override func prepare() {
        super.prepare()
        
        delegate = self
        preparePageTabBar()
        
        Motion.delay(3) { [weak self] in
            self?.selectedIndex = 2
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        
        MGPhotoHelper.completionHandler = { image in
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
}

extension AppPageTabBarController {
    fileprivate func preparePageTabBar() {
        pageTabBar.lineColor = Color.blueGrey.base
        pageTabBar.dividerColor = Color.blueGrey.lighten5
    }
}

extension AppPageTabBarController: PageTabBarControllerDelegate {
    func pageTabBarController(pageTabBarController: PageTabBarController, didTransitionTo viewController: UIViewController) {
        print("pageTabBarController", pageTabBarController, "didTransitionTo viewController:", viewController)
    }
}
