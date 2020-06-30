//
//  CuisineCell.swift
//  eating in
//
//  Created by Imogen Kraak on 31/05/2020.
//  Copyright © 2020 Imogen Kraak. All rights reserved.
//

import UIKit
import Kingfisher

class CuisineCell: UICollectionViewCell {

    @IBOutlet weak var labelText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
        
    }
    
    func configureCell(cuisine: Cuisine) {
           labelText.text = cuisine.name

}
}
