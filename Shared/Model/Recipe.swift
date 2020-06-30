//
//  Recipe.swift
//  eating in
//
//  Created by Imogen Kraak on 18/01/2020.
//  Copyright © 2020 Imogen Kraak. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Recipe {
    var name: String
    var id: String
    var category: String
    var cuisine: String
    var ingredients: String
    var ingredients2: String
    var ingredients3: String
    var ingredients4: String
    var ingredients5: String
    var ingredients6: String
    var ingredients7: String
    var recipeDetails: String
    var cookingTime: String
    var imageUrl: String
    var timeStamp: Timestamp
    
    init(
        name: String,
        id: String,
        category: String,
        cuisine: String,
        ingredients: String,
        ingredients2: String,
        ingredients3: String,
        ingredients4: String,
        ingredients5: String,
        ingredients6: String,
        ingredients7: String,
        recipeDetails: String,
        cookingTime: String,
        imageUrl: String,
        timeStamp: Timestamp = Timestamp()) {
        self.name = name
        self.id = id
        self.category = category
        self.cuisine = cuisine
        self.ingredients = ingredients
        self.ingredients2 = ingredients2
        self.ingredients3 = ingredients3
        self.ingredients4 = ingredients4
        self.ingredients5 = ingredients5
        self.ingredients6 = ingredients6
        self.ingredients7 = ingredients7
        self.recipeDetails = recipeDetails
        self.cookingTime = cookingTime
        self.imageUrl = imageUrl
        self.timeStamp = timeStamp
    }
    
    init(data: [String: Any]) {
        self.name = data["name"] as? String ?? ""
        self.id = data["id"] as? String ?? ""
        self.category = data["category"] as? String ?? ""
        self.cuisine = data["cuisine"] as? String ?? ""
        self.ingredients = data["ingredients"] as? String ?? ""
        self.ingredients2 = data["ingredients2"] as? String ?? ""
         self.ingredients3 = data["ingredients3"] as? String ?? ""
        self.ingredients4 = data["ingredients4"] as? String ?? ""
        self.ingredients5 = data["ingredients5"] as? String ?? ""
         self.ingredients6 = data["ingredients6"] as? String ?? ""
        self.ingredients7 = data["ingredients7"] as? String ?? ""
        self.recipeDetails = data["recipeDetails"] as? String ?? ""
        self.cookingTime = data["cookingTime"] as? String ?? ""
        self.imageUrl = data["imageUrl"] as? String ?? ""
        self.timeStamp = data["dataStamp"] as? Timestamp ?? Timestamp()
        

    }
    static func modelToData(recipe: Recipe) -> [String: Any] {
            
            let data : [String: Any] = [
                "name" : recipe.name,
                "id" : recipe.id,
                "category" : recipe.category,
                "cuisine" : recipe.cuisine,
                "ingredients" : recipe.ingredients,
                "ingredients2" : recipe.ingredients2,
                "ingredients3" : recipe.ingredients3,
                "ingredients4" : recipe.ingredients4,
                "ingredients5" : recipe.ingredients5,
                "ingredients6" : recipe.ingredients6,
                "ingredients7" : recipe.ingredients7,
                "recipeDetails" : recipe.recipeDetails,
                "cookingTime" : recipe.cookingTime,
                "imageUrl" : recipe.imageUrl,
                "timeStamp" : recipe.timeStamp
            ]
            
            return data
        }
    }
    
