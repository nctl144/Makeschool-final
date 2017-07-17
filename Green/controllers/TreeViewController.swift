//
//  TreeViewController.swift
//  Green
//
//  Created by Nguyễn Lâm on 7/11/17.
//  Copyright © 2017 lam. All rights reserved.
//

import UIKit
import FirebaseDatabase

class TreeViewController: UIViewController {
    @IBOutlet weak var treePhoto: UIImageView!
    @IBOutlet weak var treePhotoCartoon: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        treePhotoCartoon.image = UIImage(named: "dying-tree.png")
        // update the tree image
        DispatchQueue.main.async {

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
