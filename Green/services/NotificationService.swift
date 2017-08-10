//
//  NotificationService.swift
//  Green
//
//  Created by Nguyễn Lâm on 8/8/17.
//  Copyright © 2017 lam. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth
import FirebaseMessaging

class NotificationService {
    static func ifUserTokenExist(_ path: String, completion: @escaping (Bool) -> Void) {
        guard let userUid = Auth.auth().currentUser?.uid else {
                return completion(false)
        }
        
        let userTokenRef = Database.database().reference().child(path)
        let token = Messaging.messaging().fcmToken
        
        userTokenRef.observe(DataEventType.value, with: { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else {
                return
            }
            
            for postSnap in snapshot {
                guard let userTokens = postSnap.value as? String else {
                    continue
                }
                if (token == userTokens) {
                    return completion(true)
                }
            }
            return completion(false)
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    public static func addUserToken() {
        guard let userUid = Auth.auth().currentUser?.uid
        else {
            return
        }
        let ref = Database.database().reference()
        let token = Messaging.messaging().fcmToken
        
        let allTokenKey = ref.child("users/allTokens").childByAutoId().key
        let userTokenKey = ref.child("users/\(userUid)").childByAutoId().key
        
        let userTokenUpdate = ["users/\(userUid)/\(userTokenKey)": token ?? ""]
        let allTokenUpdate = ["allUsers/allTokens/\(allTokenKey)": token ?? ""]
        
        // check why it is false at the beginning and then turned to true?
        self.ifUserTokenExist("users/\(userUid)") { isInDB in
            if isInDB == false {
                ref.updateChildValues(userTokenUpdate)
            }
        }
        
        self.ifUserTokenExist("allUsers/allTokens") { isInDB in
            print(isInDB)
            if isInDB == false {
                ref.updateChildValues(allTokenUpdate)
            }
        }

    }
}








