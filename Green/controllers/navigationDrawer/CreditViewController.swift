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
        
        prepareToolbar()
    }
    @IBAction func goBackHomePage(_ sender: UIButton) {
        TransitionExtension.toHomePage(self.view.window)
    }
}

extension CreditViewController {
    fileprivate func prepareToolbar() {
        guard let tc = toolbarController else {
            return
        }
        
        tc.toolbar.title = "Credits"
        tc.toolbar.detail = ""
    }
}

