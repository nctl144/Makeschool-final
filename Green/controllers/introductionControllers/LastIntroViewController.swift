//
//  LastIntroViewController.swift
//  Green
//
//  Created by Nguyễn Lâm on 8/11/17.
//  Copyright © 2017 lam. All rights reserved.
//

import UIKit

class LastIntroViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func backToHomeButtonTapped(_ sender: UIButton) {
        TransitionExtension.toHomePage(self.view.window)
    }
}
