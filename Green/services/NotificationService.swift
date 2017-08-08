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
    public static func addUserToken() {
        guard let userUid = Auth.auth().currentUser?.uid
        else {
            return
        }
        let ref = Database.database().reference()
        let token = Messaging.messaging().fcmToken
        
        let childUpdates = ["users/\(userUid)/notificationToken": token ?? ""]
        
        let tokenRef = Database.database().reference().child("users").child(userUid).child("notificationToken")
        
        tokenRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let dictionary = snapshot.value as? String {
                print("aya \(dictionary)")
            } else {
                ref.updateChildValues(childUpdates)
            }
        })
    }
}
