//
//  Category.swift
//  eating in
//
//  Created by Imogen Kraak on 16/01/2020.
//  Copyright © 2020 Imogen Kraak. All rights reserved.
//

import Foundation
import  FirebaseFirestore

struct Category {
    var name: String
    var id: String
    var imageUrl: String
    var isActive: Bool = true
    var timeStamp: Timestamp
    
    init(name: String,
         id: String,
         imageUrl: String,
         isActive: Bool = true,
         timeStamp: Timestamp) {
        self.name = name
        self.id = id
        self.isActive = isActive
        self.imageUrl = imageUrl
        self.timeStamp = timeStamp
    }
    
    init(data: [String: Any]) {
    self.name = data["name"] as? String ?? ""
    self.id = data["id"] as? String ?? ""
    self.imageUrl = data["imageUrl"] as? String ?? ""
    self.isActive = data["isActive"] as? Bool ?? true
    self.timeStamp = data["timeStamp"] as? Timestamp ?? Timestamp()
}
    static func modelToData(category: Category) -> [String: Any] {
        let data : [String: Any] = [
            "name" : category.name,
            "id" : category.id,
            "imageUrl" : category.imageUrl,
            "isActive" : category.isActive,
            "timeStamp" : category.timeStamp
        
        ]
        return data
    }

}
