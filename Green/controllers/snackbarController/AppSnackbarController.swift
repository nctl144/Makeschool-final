//
//  AppSnackbarController.swift
//  Green
//
//  Created by Nguyễn Lâm on 7/25/17.
//  Copyright © 2017 lam. All rights reserved.
//

import UIKit
import Material

class AppSnackbarController: SnackbarController {
    open override func prepare() {
        super.prepare()
        delegate = self
    }
}

extension AppSnackbarController: SnackbarControllerDelegate {
    func snackbarController(snackbarController: SnackbarController, willShow snackbar: Snackbar) {
        
    }
    
    func snackbarController(snackbarController: SnackbarController, willHide snackbar: Snackbar) {
        
    }
    
    func snackbarController(snackbarController: SnackbarController, didShow snackbar: Snackbar) {
        
    }
    
    func snackbarController(snackbarController: SnackbarController, didHide snackbar: Snackbar) {
        
    }
}
