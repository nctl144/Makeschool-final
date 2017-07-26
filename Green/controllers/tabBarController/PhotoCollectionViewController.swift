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

class PhotoCollectionViewController: UIViewController {
    fileprivate var collectionView: UICollectionView!
    
    fileprivate var images = [UIImage]()
    
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
        isMotionEnabled = true
        
        TreeService.retrieveAllImages { imagesUrls in
            for imageUrl in imagesUrls {
                guard let url = URL(string: imageUrl) else {
                    return
                }
                let data = try? Data(contentsOf: url)
                self.images.append(UIImage(data: data!)!)
            }
            self.prepareCollectionView()
        }
    }
}

extension PhotoCollectionViewController {
    fileprivate func prepareCollectionView() {
        let columns: CGFloat = .phone == Device.userInterfaceIdiom ? 4 : 11
        let w: CGFloat = (view.bounds.width - columns - 1) / columns
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: w, height: w)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCollectionViewCell")
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        
        view.layout(collectionView).horizontally().top().bottom(50)
        
        collectionView.reloadData()
    }
}

extension PhotoCollectionViewController: UICollectionViewDataSource {
    @objc
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    @objc
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    @objc
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        
        cell.imageView.image = images[indexPath.item]
        cell.imageView.motionIdentifier = "photo_\(indexPath.item)"
        
        
        return cell
    }
}

extension PhotoCollectionViewController: UICollectionViewDelegate {
    @objc
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(PhotoViewController(index: indexPath.item), animated: true)
    }
}
