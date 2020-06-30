//
//  Cuisine.swift
//  eating in
//
//  Created by Imogen Kraak on 31/05/2020.
//  Copyright © 2020 Imogen Kraak. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Cuisine {
var name: String
var id: String
var isActive: Bool
var timeStamp: Timestamp
var imageUrl: String
    
init(name: String,
             id: String,
             isActive: Bool = true,
             timeStamp: Timestamp,
             imageUrl: String) {
            self.name = name
            self.id = id
            self.isActive = isActive
            self.timeStamp = timeStamp
            self.imageUrl = imageUrl
        }
        
        init(data: [String: Any]) {
        self.name = data["name"] as? String ?? ""
        self.id = data["id"] as? String ?? ""
        self.isActive = data["isActive"] as? Bool ?? true
        self.timeStamp = data["timeStamp"] as? Timestamp ?? Timestamp()
        self.imageUrl = data["imageUrl"] as? String ?? ""
    }
        static func modelToData(category: Category) -> [String: Any] {
            let data : [String: Any] = [
                "name" : category.name,
                "id" : category.id,
                "isActive" : category.isActive,
                "timeStamp" : category.timeStamp,
                "imageUrl" : category.imageUrl
            
            ]
            return data
        }
    
}


