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
    fileprivate var undoButton: FlatButton!
    
    open override func prepare() {
        super.prepare()
        prepareTabBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        prepareUndoButton()
        
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
                    
                    self.animateSnackbar()
                } else {
                    DispatchQueue.main.async(execute: {
                        let alert = UIAlertController(title: "Take the picture again u dumbass", message: "Because it is NOT A FUCKING tree, its a dog", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK I am totally sorry", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    })
                }
            })
        }
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        prepareSnackbar()
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

extension MainTabBarViewController {
    fileprivate func prepareUndoButton() {
        undoButton = FlatButton(title: "Undo", titleColor: UIColor(hexString: "FFFFFF"))
        undoButton.pulseAnimation = .backing
        undoButton.titleLabel?.font = snackbarController?.snackbar.textLabel.font
    }
    
    fileprivate func prepareSnackbar() {
        guard let snackbar = snackbarController?.snackbar else {
            return
        }
        
        snackbar.text = "Tree picture captured. Saved"
        snackbar.rightViews = [undoButton]
    }
}

extension MainTabBarViewController {
    @objc
    fileprivate func animateSnackbar() {
        guard let sc = snackbarController else {
            return
        }
        
        _ = sc.animate(snackbar: .visible, delay: 1)
        _ = sc.animate(snackbar: .hidden, delay: 4)
    }
}
