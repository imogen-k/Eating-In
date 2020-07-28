//
//  ListVC.swift
//  eating in
//
//  Created by Imogen Kraak on 01/06/2020.
//  Copyright © 2020 Imogen Kraak. All rights reserved.
//

import UIKit

class ListVC: UIViewController  {
    
    func gettingIngredients() {

        
            ingredientStore.ingredients = IngredientsUtility.fetch() ?? [[Ingredient](), [Ingredient]()]

            tableView.reloadData()
        
    }

    @IBOutlet weak var addIngredientButton: UIButton!

   @IBOutlet weak var navBarBg: UIView!
    @IBOutlet weak var categoriesButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
 
    
   var ingredientStore = IngredientStore()
    
    
    override func viewDidLoad() {
      super.viewDidLoad()
       navBarStyle()
        setupTableView()
        gettingIngredients()
        addIngredientButton.layer.cornerRadius = 8
        addIngredientButton.layer.borderColor = AppColors.Orange.cgColor
        addIngredientButton.layer.borderWidth = 1

  }
    
    func setupTableView() {
    tableView.delegate = self
    tableView.dataSource = self
        tableView.register(UINib(nibName: Identifiers.ListCells, bundle: nil), forCellReuseIdentifier: Identifiers.ListCells)
       
    }
    @IBAction func addIngredient(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: "Add ingredient", message: nil, preferredStyle: .alert)
        
        let addAction = UIAlertAction(title: "Add", style: .default) { _ in
            
            //grab text field
            guard let name = alertController.textFields?.first?.text else { return }
            
            //create ingredient
            let newIngredient = Ingredient(name: name)
            
            // add ingredient
            
            //self.ingredientStore.add(ingredient: newIngredient, at: 0)
            self.ingredientStore.add(newIngredient, at: 0)
            
            //reload data in tableview
            let indexPath = IndexPath(row: 0, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .automatic)
            
            //save
            IngredientsUtility.save(self.ingredientStore.ingredients)
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addTextField { textfield in
           
            textfield.placeholder = "Add ingredient name..."
            textfield.addTarget(self, action: #selector(self.handleTextChanged), for: .editingChanged)
        }
            alertController.addAction(addAction)
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true)
            
        }
    @objc private func handleTextChanged(   sender: UITextField) {
        
        guard let alertController = presentedViewController as? UIAlertController,
        let addAction = alertController.actions.first,
        let text = sender.text
        else  { return }
        
        addAction.isEnabled = text.trimmingCharacters(in: .whitespaces).isNotEmpty
    }
    
    
    func navBarStyle() {


        navBarBg.layer.borderWidth = 1
        navBarBg.layer.borderColor = AppColors.Black.cgColor
    }
    
    
    
}

extension ListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "To buy"
        } else {
            return "Bought"
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ingredientStore.ingredients.count
    }
    
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientStore.ingredients[section].count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.ListCells, for: indexPath) as? ListCells {
            
           cell.listText.text = ingredientStore.ingredients[indexPath.section][indexPath.row].name
            
            
        cell.configureCell()
            
            return cell
    }
        return UITableViewCell()
}
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (action, sourceView, completionHandler) in
            
            guard let bought = self.ingredientStore.ingredients[indexPath.section][indexPath.row].bought else { return }
            
            self.ingredientStore.remove(at: indexPath.row, bought: bought)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
           
          IngredientsUtility.save(self.ingredientStore.ingredients)
            
            completionHandler(true)
            
        
        }
        
        deleteAction.image = #imageLiteral(resourceName: "deleteIngredient")
        deleteAction.backgroundColor = AppColors.Orange
       
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let boughtAction = UIContextualAction(style: .normal, title: nil) { (action, sourceView, completionHandler) in
            
        self.ingredientStore.ingredients[0][indexPath.row].bought = true
            
            let boughtIngredient = self.ingredientStore.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
           // self.ingredientStore.add(ingredient: boughtIngredient, at: 0, bought: true)
            self.ingredientStore.add(boughtIngredient, at: 0, bought: true)
            tableView.insertRows(at: [IndexPath(row: 0, section: 1)], with: .automatic)
            
         IngredientsUtility.save(self.ingredientStore.ingredients)
            
            completionHandler(true)
        }
        boughtAction.image = #imageLiteral(resourceName: "doneIngredient")
        boughtAction.backgroundColor = AppColors.Green
    
        return indexPath.section == 0 ? UISwipeActionsConfiguration(actions: [boughtAction]) : nil
    }
}
