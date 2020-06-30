//
//  CategoryCell.swift
//  eating in
//
//  Created by Imogen Kraak on 18/04/2020.
//  Copyright © 2020 Imogen Kraak. All rights reserved.
//

import UIKit
import Kingfisher

class CategoryCell: UICollectionViewCell {

    @IBOutlet weak var categoryImage: UIImageView!
    
    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var viewBg: UIView!
    
    @IBOutlet weak var backgroundShadow: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        categoryImage.layer.cornerRadius = 7
        categoryImage.layer.opacity = 0.85
        backgroundShadow.layer.cornerRadius = 10
//        viewBg.layer.shadowColor = AppColors.Orange.cgColor
//        viewBg.layer.shadowOffset = CGSize(width: 10, height: 0)
//        viewBg.layer.shadowPath = UIBezierPath(rect: viewBg.bounds).cgPath
//        viewBg.layer.shadowRadius = 20
//        viewBg.layer.shadowOpacity = 0.6
//        viewBg.layer.shouldRasterize = true
//        viewBg.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        
     
        
    }

    func configureCell(category: Category) {
        categoryTitle.text = category.name
        if let url = URL(string: category.imageUrl) {
            let options : KingfisherOptionsInfo = [KingfisherOptionsInfoItem.transition(.fade(0.1))]
            categoryImage.kf.indicatorType = .activity
            categoryImage.kf.setImage(with: url, options: options)
        }
    }
}
