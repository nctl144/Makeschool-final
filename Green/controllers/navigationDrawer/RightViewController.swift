//
//  RightViewController.swift
//  Green
//
//  Created by Nguyễn Lâm on 7/24/17.
//  Copyright © 2017 lam. All rights reserved.
//

//import UIKit
//import Material
//
//class RightViewController: UIViewController {
//    fileprivate var rootButton: FlatButton!
//    
//    open override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = Color.blue.base
//        
//        prepareRootButton()
//    }
//}
//
//extension RightViewController {
//    fileprivate func prepareRootButton() {
//        rootButton = FlatButton(title: "Root VC", titleColor: .white)
//        rootButton.pulseColor = .white
//        rootButton.addTarget(self, action: #selector(handleRootButton), for: .touchUpInside)
//        
//        view.layout(rootButton).horizontally().center()
//    }
//}
//
//extension RightViewController {
//    @objc
//    fileprivate func handleRootButton() {
//        
//    }
//    
//    fileprivate func closeNavigationDrawer(result: Bool) {
//        navigationDrawerController?.closeRightView()
//    }
//}
