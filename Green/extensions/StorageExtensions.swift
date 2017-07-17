//
//  StorageExtensions.swift
//  Green
//
//  Created by Nguyễn Lâm on 7/14/17.
//  Copyright © 2017 lam. All rights reserved.
//

import Foundation
import FirebaseStorage

// generate a new name for each image
extension StorageReference {
    static let dateFormatter = ISO8601DateFormatter()
    
    static func newPostImageReference() -> StorageReference {
        let timestamp = dateFormatter.string(from: Date())
        
        return Storage.storage().reference().child("treeimages/\(timestamp).jpg")
    }
}
