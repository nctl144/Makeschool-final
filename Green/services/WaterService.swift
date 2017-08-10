//
//  WaterService.swift
//  Green
//
//  Created by Nguyễn Lâm on 8/8/17.
//  Copyright © 2017 lam. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

class WaterService {
    static func markAsWatered() {
        guard let userUid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let dateformatter = DateFormatter()
        
        dateformatter.dateFormat = "MM-dd-yyyy"
        
        let today = dateformatter.string(from: NSDate() as Date)
        
        let ref = Database.database().reference()
        ref.child("water").child(userUid).updateChildValues([today: "true"])
    }
}
