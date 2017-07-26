//
//  UIStoryboardExtensions.swift
//  Green
//
//  Created by Nguyễn Lâm on 7/21/17.
//  Copyright © 2017 lam. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    enum MGType: String {
        case main
        case login
        case photo
        
        var filename: String {
            return rawValue.capitalized
        }
    }
    
    convenience init(type: MGType, bundle: Bundle? = nil) {
        self.init(name: type.filename, bundle: bundle)
    }
    
    static func initialViewController(for type: MGType) -> UIViewController {
        let storyboard = UIStoryboard(type: type)
        
        guard let initialViewController = storyboard.instantiateInitialViewController() else {
            fatalError("could not instantiate the view controller for \(type.filename) storyboard")
        }
        return initialViewController
    }
}
