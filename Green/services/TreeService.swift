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
import FirebaseDatabase.FIRDataSnapshot
import FirebaseAuth

struct TreeService {
    static let dateFormatter = ISO8601DateFormatter()
    
    static func createImageUrl(for image: UIImage) {
        let imageRef = StorageReference.newPostImageReference()
        let ref = Database.database().reference()
        
        guard let userUid = Auth.auth().currentUser?.uid
        else {
            return
        }
        
        StorageService.uploadImage(image, at: imageRef) { (downloadURL) in
            guard let downloadURL = downloadURL else {
                return
            }
            
            let urlString = downloadURL.absoluteString
            let postKey = ref.child("posts/\(userUid)/allImages").childByAutoId().key
            
            let childUpdates = ["posts/\(userUid)/postImageUrl": urlString,
                                "posts/\(userUid)/allImages/\(postKey)": urlString]
            ref.updateChildValues(childUpdates)
        }
    }
    
    static func retrieveImage(completion: @escaping (String) -> Void) {
        guard let userUid = Auth.auth().currentUser?.uid
        else {
            return
        }
    
        let ref = Database.database().reference()
        
        ref.child("posts").child(userUid).observe(DataEventType.value, with: { (snapshot) in
            if let dictionary = snapshot.value as? NSDictionary {
                let imageUrl = dictionary["postImageUrl"] as? String
                completion(imageUrl!)
            }
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    static func retrieveAllImages(completion: @escaping ([String]) -> Void) {
        guard let userUid = Auth.auth().currentUser?.uid
            else {
                return
        }
        
        let ref = Database.database().reference()
        
        ref.child("posts").child(userUid).child("allImages").observe(DataEventType.value, with: { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else {
                return completion([])
            }
            
            var images: [String] = []
            
            for postSnap in snapshot {
                guard let imageUrl = postSnap.value as? String else {
                    continue
                }
                images.append(imageUrl)
            }
            completion(images)
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
}
