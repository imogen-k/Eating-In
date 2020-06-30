//
//  Extensions.swift
//  eating in
//
//  Created by Imogen Kraak on 16/01/2020.
//  Copyright © 2020 Imogen Kraak. All rights reserved.
//

import Foundation
import UIKit
import Firebase

extension String {
    var isNotEmpty : Bool {
        return !isEmpty
    }
}

extension UIViewController {
    func simpleAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

