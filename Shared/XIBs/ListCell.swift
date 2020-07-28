//
//  ListCell.swift
//  eating in
//
//  Created by Imogen Kraak on 30/06/2020.
//  Copyright © 2020 Imogen Kraak. All rights reserved.
//

import UIKit

class ListCell: UITableViewCell {

    class ListCell: UITableViewCell {
        
   
        
        var ingredientStore = IngredientStore()
        var ingredients: [Ingredient]!

        override func awakeFromNib() {
            super.awakeFromNib()
            
            let ingredientToBuy = [Ingredient(name: "Courgette"), Ingredient(name: "Noodles"), Ingredient(name: "Banana")]
            let ingredientBought = [Ingredient(name: "Potato")]
            
            ingredientStore.ingredients = [ingredientToBuy, ingredientBought]
            
        }
        func configureCell() {
            
           
    }
    
}
}
