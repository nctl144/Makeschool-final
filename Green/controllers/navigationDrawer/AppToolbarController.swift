//
//  AppToolbarController.swift
//  Green
//
//  Created by Nguyễn Lâm on 7/24/17.
//  Copyright © 2017 lam. All rights reserved.
//

import UIKit
import Material

class AppToolbarController: ToolbarController {
    fileprivate var menuButton: IconButton!
    fileprivate var switchControl: Switch!
    fileprivate var moreButton: IconButton!
    
    override func prepare() {
        super.prepare()
        prepareMenuButton()
        prepareMoreButton()
        prepareStatusBar()
        prepareToolbar()
    }
}

extension AppToolbarController {
    fileprivate func prepareMenuButton() {
        menuButton = IconButton(image: Icon.cm.menu, tintColor: .white)
        menuButton.addTarget(self, action: #selector(handleMenuButton), for: .touchUpInside)
    }
    
    fileprivate func prepareMoreButton() {
        moreButton = IconButton(image: Icon.cm.moreVertical, tintColor: .white)
        moreButton.addTarget(self, action: #selector(handleMoreButton), for: .touchUpInside)
    }
    
    fileprivate func prepareStatusBar() {
        statusBarStyle = .lightContent
        
        // Access the statusBar.
        statusBar.backgroundColor = UIColor(hexString: "226F54")
    }
    
    fileprivate func prepareToolbar() {
        toolbar.depthPreset = .none
        toolbar.backgroundColor = UIColor(hexString: "226F54")
        
        toolbar.title = "Green"
        toolbar.titleLabel.textColor = .white
        toolbar.titleLabel.textAlignment = .left
        
        toolbar.detailLabel.textColor = .white
        toolbar.detailLabel.textAlignment = .left
        
        toolbar.leftViews = [menuButton]
        toolbar.rightViews = [moreButton]
    }
}

extension AppToolbarController {
    @objc
    fileprivate func handleMenuButton() {
        navigationDrawerController?.toggleLeftView()
    }
    
    @objc
    fileprivate func handleMoreButton() {
        navigationDrawerController?.toggleRightView()
    }
}
