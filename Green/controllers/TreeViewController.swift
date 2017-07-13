//
//  TreeViewController.swift
//  Green
//
//  Created by Nguyễn Lâm on 7/11/17.
//  Copyright © 2017 lam. All rights reserved.
//

import UIKit

class TreeViewController: UIViewController {
    @IBOutlet weak var treePhoto: UIImageView!
    @IBOutlet weak var treePhotoCartoon: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        treePhotoCartoon.image = UIImage(named: "dying-tree.png")
        // update the tree image
        DispatchQueue.main.async {
            self.treePhoto.image = TreeInfo.treeImage
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
