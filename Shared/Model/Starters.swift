//
//  Starters.swift
//  eating in
//
//  Created by Imogen Kraak on 14/03/2020.
//  Copyright © 2020 Imogen Kraak. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Starters {
    var name: String
    var id: String
    var ingredients: [String]
    var recipeDetails: String
    var cookingTime: String
    var imageUrl: String
    var timeStamp: Timestamp
    
    init(name: String,
             id: String,
             imageUrl: String,
             ingredients: String,
             cookingTime: String,
             recipeDetails: String,
             timeStamp: Timestamp) {
            self.name = name
            self.id = id
            self.ingredients = [ingredients]
            self.imageUrl = imageUrl
            self.cookingTime = cookingTime
            self.recipeDetails = recipeDetails
            self.timeStamp = timeStamp
        
        }
        
        init(data: [String: Any]) {
        self.name = data["name"] as? String ?? ""
        self.id = data["id"] as? String ?? ""
        self.imageUrl = data["imageUrl"] as? String ?? ""
        self.ingredients = data["ingredients"] as? Array ?? [""]
        self.cookingTime = data["cookingTime"] as? String ?? ""
        self.recipeDetails = data["recipeDetails"] as? String ?? ""
        self.timeStamp = data["timeStamp"] as? Timestamp ?? Timestamp()
    }
    static func modelToData(starter: Starters) -> [String: Any] {
        let data : [String: Any] = [
            "name" : starter.name,
            "id" : starter.id,
            "imageUrl" : starter.imageUrl,
            "ingredients" : starter.ingredients,
            "cookingTime" : starter.cookingTime,
            "recipeDetails" : starter.recipeDetails,
            "timeStamp" : starter.timeStamp
        ]
        return data
    }

}

