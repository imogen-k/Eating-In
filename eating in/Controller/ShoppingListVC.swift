//
//  ShoppingListVC.swift
//  eating in
//
//  Created by Imogen Kraak on 03/06/2020.
//  Copyright © 2020 Imogen Kraak. All rights reserved.
//

import UIKit

class ShoppingListVC: UITableViewController {
    
}

extension ShoppingListVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Task"
        return cell
    }
}
