//
//  AppNavigationController.swift
//  Green
//
//  Created by Nguyễn Lâm on 7/26/17.
//  Copyright © 2017 lam. All rights reserved.
//

import UIKit
import Material

class AppNavigationController: NavigationController {
    open override func prepare() {
        super.prepare()
        isMotionEnabled = true
        
        navigationBar.depthPreset = .none
        navigationBar.dividerColor = Color.grey.lighten3
        (navigationBar as? NavigationBar)?.backButtonImage = Icon.close?.tint(with: Color.red.base)
    }
}
