//
//  WaterViewController.swift
//  Green
//
//  Created by Nguyễn Lâm on 7/27/17.
//  Copyright © 2017 lam. All rights reserved.
//

import UIKit
import Material

class WaterViewController: UIViewController {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareTabBarItem()
    }
    
    private func prepareTabBarItem() {
        tabBarItem.title = "Water"
        tabBarItem.image = Icon.starBorder?.tint(with: Color.blueGrey.base)
        tabBarItem.selectedImage = Icon.starBorder?.tint(with: Color.blue.base)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
