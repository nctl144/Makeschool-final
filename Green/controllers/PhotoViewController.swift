//
//  PhotoViewController.swift
//  Green
//
//  Created by Nguyễn Lâm on 7/26/17.
//  Copyright © 2017 lam. All rights reserved.
//

import UIKit
import Material

class PhotoViewController: UIViewController {
    fileprivate var collectionView: CollectionView!
    
    var dataSourceItems = [DataSourceItem]()
    
    fileprivate var photos: [UIImage] = []
    
    fileprivate var fabButton: FABButton!
    
    fileprivate var index: Int
    
    public required init?(coder aDecoder: NSCoder) {
        index = 0
        super.init(coder: aDecoder)
    }
    
    public init(index: Int) {
        self.index = index
        super.init(nibName: nil, bundle: nil)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        preparePhotos()
        prepareCollectionView()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension PhotoViewController {
    fileprivate func preparePhotos() {
        TreeService.retrieveAllImages { imagesUrls in
            for imageUrl in imagesUrls {
                guard let url = URL(string: imageUrl) else {
                    return
                }
                let data = try? Data(contentsOf: url)
                let w = self.view.bounds.width
                self.dataSourceItems.append(DataSourceItem(data: UIImage(data: data!)!, width: w))
            }
        }
    }
    
    fileprivate func prepareCollectionView() {
        collectionView = CollectionView()
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.scrollDirection = .horizontal
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCollectionViewCell")
        
        view.layout(collectionView).center().width(view.bounds.width).height(350)
        
        collectionView.scrollRectToVisible(CGRect(x: view.bounds.width * CGFloat(index), y: 0, width: view.bounds.width, height: 350), animated: false)
    }
}

extension PhotoViewController: CollectionViewDataSource {
    @objc
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    @objc
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSourceItems.count
    }
    
    @objc
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        guard let image = dataSourceItems[indexPath.item].data as? UIImage else {
            return cell
        }
        
        cell.imageView.image = image
        cell.imageView.motionIdentifier = "photo_\(indexPath.item)"
        
        return cell
    }
}

extension PhotoViewController: CollectionViewDelegate {
    
}
