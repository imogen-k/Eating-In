//
//  IngredientStore.swift
//  eating in
//
//  Created by Imogen Kraak on 30/06/2020.
//  Copyright © 2020 Imogen Kraak. All rights reserved.
//

import Foundation

class IngredientStore {
    
    var ingredients = [[Ingredient](), [Ingredient]()]
    
    func add(_ ingredient: Ingredient, at index: Int, bought: Bool = false) {
    
        let section = bought ? 1 : 0
        
        ingredients[section].insert(ingredient, at: index)
}

    func remove (at index: Int, bought: Bool = false) -> Ingredient {
        
        let section = bought ? 1 : 0
        
        return ingredients[section].remove(at: index)
    }

}
