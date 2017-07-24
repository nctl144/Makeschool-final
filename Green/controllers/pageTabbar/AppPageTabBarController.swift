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
        view.backgroundColor = Color.blueGrey.lighten5
        
        delegate = self
        preparePageTabBar()
    }
}

extension AppPageTabBarController {
    fileprivate func preparePageTabBar() {
        pageTabBarAlignment = .top
        pageTabBar.dividerColor = nil
        pageTabBar.lineColor = Color.blue.lighten3
        pageTabBar.lineAlignment = .bottom
        pageTabBar.backgroundColor = Color.blue.darken2
    }
}

extension AppPageTabBarController: PageTabBarControllerDelegate {
    func pageTabBarController(pageTabBarController: PageTabBarController, didTransitionTo viewController: UIViewController) {
        print("pageTabBarController", pageTabBarController, "didTransitionTo viewController:", viewController)
    }
}
