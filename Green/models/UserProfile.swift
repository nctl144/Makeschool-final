//
//  User.swift
//  Green
//
//  Created by Nguyễn Lâm on 7/11/17.
//  Copyright © 2017 lam. All rights reserved.
//

import Foundation
import FacebookCore

struct MyProfileRequest: GraphRequestProtocol {
    struct Response: GraphResponseProtocol {
        var username: String?
        var userId: String?
        
        init(rawResponse: Any?) {
            guard let response = rawResponse as? Dictionary<String, Any> else {
                return
            }
            
            if let username = response["name"] as? String {
                self.username = username
            }
            
            if let userId = response["id"] as? String {
                self.userId = userId
            }
        }
    }
    
    var graphPath = "/me"
    var parameters: [String : Any]? = ["fields": "id, name"]
    var accessToken = AccessToken.current
    var httpMethod: GraphRequestHTTPMethod = .GET
    var apiVersion: GraphAPIVersion = .defaultVersion
}

struct UserProfile {
    static var userId:String? = String()
    
    static var profilePicUrl = "http://graph.facebook.com/\(userId!)/picture?type=large"
    
    static var username: String? = String()
}
