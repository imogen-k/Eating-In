//
//  RoundedViews.swift
//  eating in
//
//  Created by Imogen Kraak on 16/01/2020.
//  Copyright © 2020 Imogen Kraak. All rights reserved.
//

import Foundation
import UIKit

class RoundedButton : UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 5
    }
}

class RoundedShadowView : UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
    layer.cornerRadius = 5
    layer.shadowColor = AppColors.Black.cgColor
    layer.shadowOpacity = 0.4
    layer.shadowOffset = CGSize.zero
    layer.shadowRadius = 5
    }
}

class RoundedImageView : UIImageView {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 15
    }
}
