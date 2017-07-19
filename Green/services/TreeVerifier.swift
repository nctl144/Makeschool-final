//
//  TreeVerifier.swift
//  Green
//
//  Created by Nguyễn Lâm on 7/19/17.
//  Copyright © 2017 lam. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class TreeVerifier {
    private static let googleAPIKey = "AIzaSyBWULC40id62H2C7Iao2ZjBu4B5mU7vkvc"

    static var googleURL: URL {
        return URL(string: "https://vision.googleapis.com/v1/images:annotate?key=\(googleAPIKey)")!
    }
    
    // resize the image
    static func resize(imageSize: CGSize, image: UIImage) -> Data {
        UIGraphicsBeginImageContext(imageSize)
        
        image.draw(in: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        let resizedImage = UIImagePNGRepresentation(newImage!)
        UIGraphicsEndImageContext()
        return resizedImage!
    }
    
    
    // return the image data
    static func base64EncodeImage(_ image: UIImage) -> String {
        var imageData = UIImagePNGRepresentation(image)
        
        // resize the image if it is larger than 2mb limit
        if (imageData!.count > 2097152) {
            let oldSize: CGSize = image.size
            let newSize: CGSize = CGSize(width: 800, height: oldSize.height / oldSize.width * 800)
            imageData = resize(imageSize: newSize, image: image)
        }
        
        return imageData!.base64EncodedString(options: .endLineWithCarriageReturn)
    }
    
    
    static func createRequest(with imageBase64: String, url googleURL: URL, completion: @escaping ([String]) -> Void) {
        
        var request = URLRequest(url: googleURL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(Bundle.main.bundleIdentifier ?? "", forHTTPHeaderField: "X-Ios-Bundle-Identifier")
        
        // build api request
        let jsonRequest = [
            "requests": [
                "image": [
                    "content": imageBase64
                ],
                "features": [
                    [
                        "type": "LABEL_DETECTION",
                        "maxResults": 10
                    ],
                    [
                        "type": "FACE_DETECTION",
                        "maxResults": 10
                    ]
                ]
            ]
        ]
        
        let jsonObject = JSON(jsonDictionary: jsonRequest)
        
        // serialize the json
        guard let data = try? jsonObject.rawData() else {
            return
        }
        
        request.httpBody = data
        
        Alamofire.request(request).responseJSON(queue: .global(), options: []) { response in
            print(response)
        }
    }
}
