//
//  TreeService.swift
//  Green
//
//  Created by Nguyễn Lâm on 7/14/17.
//  Copyright © 2017 lam. All rights reserved.
//

import Foundation
import UIKit
import FirebaseStorage
import FirebaseDatabase

struct TreeService {
    static let dateFormatter = ISO8601DateFormatter()
    
    static func uploadImage(for image: UIImage) {
        let timestamp = dateFormatter.string(from: Date())
        let imageRef = Storage.storage().reference().child("treeimages/\(timestamp).jpg")
        StorageService.uploadImage(image, at: imageRef) { (downloadURL) in
            guard let downloadURL = downloadURL else {
                return
            }
            
            let urlString = downloadURL.absoluteString
            print("image url: \(urlString)")
        }
    }
}
