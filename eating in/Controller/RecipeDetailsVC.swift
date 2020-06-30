//
//  RecipeDetailsVC.swift
//  eating in
//
//  Created by Imogen Kraak on 05/02/2020.
//  Copyright © 2020 Imogen Kraak. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Kingfisher

protocol RecipeDelegate : class {
func recipeFavorited(recipe: Recipe)
}

class RecipeDetailsVC: UIViewController {
    
    weak var delegate : RecipeDelegate?
   // private var recipe: Recipe!
    
    //outlets
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeDetails: UILabel!
    @IBOutlet weak var howToCookBg: UIView!
    @IBOutlet weak var plusButton: UIButton!
    //ingredient outlets
    @IBOutlet weak var ingredientsList: UILabel!
    @IBOutlet weak var ingredientItem2: UILabel!
    @IBOutlet weak var ingredientItem3: UILabel!
    @IBOutlet weak var ingredientItem4: UILabel!
    
    @IBOutlet weak var ingredients5: UILabel!
    @IBOutlet weak var ingredients6: UILabel!
    @IBOutlet weak var ingredients7: UILabel!
    
    var recipe: Recipe!
    @IBOutlet weak var shoppingListView: UIView!
    
    // navigation
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        recipeName.text = recipe.name
        recipeDetails.text = recipe.recipeDetails
        ingredientsList.text = recipe.ingredients
        ingredientItem2.text = recipe.ingredients2
        ingredientItem3.text = recipe.ingredients3
        ingredientItem4.text = recipe.ingredients4
        ingredients5.text = recipe.ingredients5
        ingredients6.text = recipe.ingredients6
        ingredients7.text = recipe.ingredients7
       recipeImage.layer.opacity = 0.7
        shoppingListView.layer.borderWidth = 1
        shoppingListView.layer.borderColor = AppColors.Orange.cgColor
        shoppingListView.layer.cornerRadius = 8
        
    
        howToCookBg.layer.cornerRadius = 5
    
        
        if let url = URL(string: recipe.imageUrl) {
        let placeholder = UIImage(named: "placeholder")
        let options : KingfisherOptionsInfo = [KingfisherOptionsInfoItem.transition(.fade(0.1))]
        recipeImage.kf.indicatorType = .activity
        recipeImage.kf.setImage(with: url, placeholder: placeholder, options: options)
        
       
    }
    }
        
    var favourite = false
    
    @IBAction func plusClicked(_ sender: UIButton) {

        if favourite {
            sender.setImage( UIImage(named:"Plus"), for: .normal)
               favourite = false
           } else {
            sender.setImage(UIImage(named:"Minus"), for: .normal)
               favourite = true
           }
    }
    
    

        func setupNavBar() {
          
            
        }
    
    override func viewDidAppear(  _ animated: Bool) {
        setupNavBar()
           
       
           }
    
    
        }
    
  
   




