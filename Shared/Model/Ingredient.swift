//
//  Ingredient.swift
//  eating in
//
//  Created by Imogen Kraak on 10/06/2020.
//  Copyright © 2020 Imogen Kraak. All rights reserved.
//

import Foundation

class Ingredient: NSObject, NSCoding {
    
    var name: String?
    var bought: Bool?
    
    private let nameKey = "name"
    private let boughtKey = "bought"
    
    init(name: String, bought: Bool = false) {
    self.name = name
    self.bought = bought
    
}
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(bought, forKey: "bought")
    }
    
    required init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: nameKey) as? String,
            let bought = aDecoder.decodeObject(forKey: boughtKey) as? Bool
        
            else { return }
        
        self.name = name
        self.bought = bought
    }
}
