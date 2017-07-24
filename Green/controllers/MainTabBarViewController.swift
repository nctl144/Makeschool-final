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
    
    open override func prepare() {
        super.prepare()
        prepareTabBar()
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
