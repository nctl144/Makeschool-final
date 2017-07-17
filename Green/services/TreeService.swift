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
    
    static func createImageUrl(for image: UIImage) {
        let imageRef = StorageReference.newPostImageReference()
        let ref = Database.database().reference()
        let key = ref.child("posts").childByAutoId().key
        StorageService.uploadImage(image, at: imageRef) { (downloadURL) in
            guard let downloadURL = downloadURL else {
                return
            }
            
            let urlString = downloadURL.absoluteString
            let childUpdates = ["posts/\(key)": urlString]
            ref.updateChildValues(childUpdates)
        }
    }
}
