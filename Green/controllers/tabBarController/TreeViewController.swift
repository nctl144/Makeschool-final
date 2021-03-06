//
//  TreeViewController.swift
//  Green
//
//  Created by Nguyễn Lâm on 7/11/17.
//  Copyright © 2017 lam. All rights reserved.
//

import UIKit
import FirebaseDatabase
import AlamofireImage
import FacebookShare
import Material

class TreeViewController: UIViewController {

    @IBOutlet weak var treePhoto: UIImageView!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var messengerShareButton: UIButton!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareTabBarItem()
    }
    
    private func prepareTabBarItem() {
        tabBarItem.title = "Your trees"
        tabBarItem.image = Icon.cm.photoLibrary?.tint(with: Color.blueGrey.base)
        tabBarItem.selectedImage = Icon.cm.photoLibrary?.tint(with: Color.blue.base)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTimeline), name: NSNotification.Name(rawValue: "upload"), object: nil)

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

    @IBAction func shareButtonTapped(_ sender: UIButton) {
        TreeService.retrieveImage { imageUrl in
            
            // we know that the image always exists so we can unwrap it
            let url = URL(string: imageUrl)
            let data = try? Data(contentsOf: url!)
            let image: UIImage = UIImage(data: data!)!
            
            let photo = Photo(image: image, userGenerated: true)
            let content = PhotoShareContent(photos: [photo])
            do {
                try ShareDialog.show(from: self, content: content)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func messengerShareButtonTapped(_ sender: UIButton) {
        TreeService.retrieveImage { imageUrl in
            // we know that the image always exists so we can unwrap it
            let url = URL(string: imageUrl)
            let data = try? Data(contentsOf: url!)
            let image: UIImage = UIImage(data: data!)!
            
            let photo = Photo(image: image, userGenerated: true)
            let content = PhotoShareContent(photos: [photo])
            let shareDialog = MessageDialog(content: content)
            do {
                shareDialog.completion = { result in
                    // Handle share results
                }
                
                try shareDialog.show() 
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
}
