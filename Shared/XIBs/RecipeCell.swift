//
//  RecipeCell.swift
//  eating in
//
//  Created by Imogen Kraak on 20/01/2020.
//  Copyright © 2020 Imogen Kraak. All rights reserved.
//

import UIKit
import Kingfisher

class RecipeCell: UITableViewCell {
    

    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var recipeCell: UIView!
    @IBOutlet weak var background: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
     
        
        //recipeCell.layer.borderWidth = 3
        //recipeCell.layer.borderColor = AppColors.White.cgColor
        recipeCell.layer.cornerRadius = 7
//        recipeCell.layer.shadowColor = AppColors.Black.cgColor
//        recipeCell.layer.shadowOpacity = 0.4
//        recipeCell.layer.shadowOffset = CGSize.zero
//        recipeCell.layer.shadowRadius = 5
        background.layer.cornerRadius = 7
    }

    func configureCell(recipe: Recipe) {
        recipeTitle.text = recipe.name
        
      //  if let url = URL(string: recipe.imageUrl) {
        //    recipeImage.kf.setImage(with: url)
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
    }
    

