//
//  LaunchScreenVC.swift
//  eating in
//
//  Created by Imogen Kraak on 30/06/2020.
//  Copyright © 2020 Imogen Kraak. All rights reserved.
//

import UIKit


class LaunchScreenVC: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.2, animations: {
            self.titleLabel.transform = CGAffineTransform(translationX: 0, y: self.view.bounds.size.height)
        
        }) { (success) in
            
            let sb = UIStoryboard(name: "Main", bundle: nil)
            _ = sb.instantiateInitialViewController()
        }
        
    }


}
