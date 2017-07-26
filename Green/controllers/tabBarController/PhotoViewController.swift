//
//  PhotoViewController.swift
//  Green
//
//  Created by Nguyễn Lâm on 7/25/17.
//  Copyright © 2017 lam. All rights reserved.
//

import UIKit
import Kingfisher
import Material

class PhotoViewController: UIViewController {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareTabBarItem()
    }
    
    private func prepareTabBarItem() {
        tabBarItem.title = "All photos"
        tabBarItem.image = Icon.photoLibrary?.tint(with: Color.blueGrey.base)
        tabBarItem.selectedImage = Icon.photoLibrary?.tint(with: Color.blue.base)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TreeService.retrieveAllImages { image in
            print(image)
        }
    }
}
