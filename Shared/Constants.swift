//
//  Constants.swift
//  eating in
//
//  Created by Imogen Kraak on 16/01/2020.
//  Copyright © 2020 Imogen Kraak. All rights reserved.
//

import Foundation
import UIKit

struct Storyboard {
    static let LoginStoryboard = "LoginStoryboard"
    static let Main = "Main"
}

struct StoryboardId {
    static let loginVC = "loginVC"
}


struct AppColors {
    static let Orange = #colorLiteral(red: 0.9411764706, green: 0.5843137255, blue: 0.3921568627, alpha: 1)
    static let Black = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    static let White = #colorLiteral(red: 0.9687432647, green: 1, blue: 0.9540372491, alpha: 1)
    static let Green = #colorLiteral(red: 0.1490196078, green: 0.2745098039, blue: 0.2823529412, alpha: 1)
}

struct Identifiers {
    static let IngredientCell = "IngredientCell"
    static let StarterCell = "StarterCell"
    static let CategoryCell = "CategoryCell"
    static let RecipeCell = "RecipeCell"
    static let CuisineCell = "CuisineCell"
    static let ListCell = "ListCell"
    static let ListCells = "ListCells"
}

struct Segues {
    static let ToRecipes = "ToRecipes"
    static let ToRegister = "ToRegister"
    static let ToRecipeDetails = "ToRecipeDetails"
    static let ToIngredients = "ToIngredients"
    static let BackToRecipes = "BackToRecipes"
    static let ToCuisines = "ToCuisines"
    static let ToCuisinesAgain = "ToCuisinesAgain"
    static let ToRecipesAgain = "ToRecipesAgain"
    static let ToRecipeDetailsCuisine = "ToRecipeDetailsCuisine"
    static let ToHome = "ToHome"
    static let ToHomeAgain = "ToHomeAgain"
    static let ToFavourites = "ToFavourites"
    static let ToFavouritesAgain = "ToFavouritesAgain"
    static let ToListFromHome = "ToListFromHome"
    static let ToHomeFromLists = "ToHomeFromLists"
    static let DetailsToHome = "DetailsToHome"
    static let RecipeDetailsToList = "RecipeDetailsToList"
}

struct AppImages {
    static let Tick = "check green"
    static let redTick = "check red"
    static let placeholder = "placeholder"
}
