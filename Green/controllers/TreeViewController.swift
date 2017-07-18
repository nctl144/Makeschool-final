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
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var contentView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTimeline), name: NSNotification.Name(rawValue: "upload"), object: nil)
        
        // Do any additional setup after loading the view.
        treePhotoCartoon.image = UIImage(named: "dying-tree.png")
        // update the tree image
        TreeService.retrieveImage { imageUrl in
            self.treePhoto.kf.setImage(with: URL(string: imageUrl))
        }

    }
    
    func reloadTimeline() {
        TreeService.retrieveImage { imageUrl in
            self.treePhoto.kf.setImage(with: URL(string: imageUrl))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
