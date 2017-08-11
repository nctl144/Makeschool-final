//
//  CreditViewController.swift
//  Green
//
//  Created by Nguyễn Lâm on 7/24/17.
//  Copyright © 2017 lam. All rights reserved.
//

import UIKit
import Material

class CreditViewController: UIViewController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.purple.base
        
        prepareToolbar()
    }
}

extension CreditViewController {
    fileprivate func prepareToolbar() {
        guard let tc = toolbarController else {
            return
        }
        
        tc.toolbar.title = "Transitioned"
        tc.toolbar.detail = "View Controller"
    }
}

