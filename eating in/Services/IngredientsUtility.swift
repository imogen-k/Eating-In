//
//  IngredientsUtility.swift
//  eating in
//
//  Created by Imogen Kraak on 12/06/2020.
//  Copyright © 2020 Imogen Kraak. All rights reserved.
//

import Foundation

class IngredientsUtility {
    
    private static let key = "ingredients"
    
    private static func archive(_ ingredients: [[Ingredient]]) -> Data? {
        return try? NSKeyedArchiver.archivedData(withRootObject: ingredients, requiringSecureCoding: false)
        
        
    }

        static func fetch() -> [[Ingredient]]? {
            guard let unarchivedData = UserDefaults.standard.object(forKey: key) as? Data else { return nil }
            return try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(unarchivedData) as? [[Ingredient]] ?? [[]]
        }
        
        
    static func save(_ ingredients: [[Ingredient]]) {
        
        let archivedIngredients = archive(ingredients)
        
        UserDefaults.standard.set(archivedIngredients, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
}

