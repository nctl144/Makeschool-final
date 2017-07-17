//
//  TreeInfo.swift
//  Green
//
//  Created by Nguyễn Lâm on 7/13/17.
//  Copyright © 2017 lam. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase.FIRDataSnapshot

class TreeInfo {
    var imageUrl: String
    
    init(imageUrl: String) {
        self.imageUrl = imageUrl
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String: Any],
        let imageUrl = dict["imageUrl"] as? String
        else {
            return nil
        }
        
        self.imageUrl = imageUrl
    }
}
