//
//  FavouritesVC.swift
//  eating in
//
//  Created by Imogen Kraak on 01/06/2020.
//  Copyright © 2020 Imogen Kraak. All rights reserved.
//

import UIKit

class FavouritesVC: UIViewController {

    @IBOutlet weak var navBarBg: UIView!

    @IBOutlet weak var categoriesDotsStack: UIStackView!
  
    var recipe: Recipe!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    navBarStyle()
        
  
    }
    

   func navBarStyle() {
    categoriesDotsStack.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
       
        navBarBg.layer.borderWidth = 1
        navBarBg.layer.borderColor = AppColors.Black.cgColor
    }

    
    

    
    
}
