//
//  RecipesCuisinesVC.swift
//  eating in
//
//  Created by Imogen Kraak on 01/06/2020.
//  Copyright © 2020 Imogen Kraak. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Kingfisher

class RecipesCuisinesVC: UIViewController {
    
    
    var recipes = [Recipe]()
    var cuisine: Cuisine!
    var listener: ListenerRegistration!
    var db : Firestore!
    var selectedRecipe: Recipe!
    var selectedCuisine: Cuisine!
    var cuisines = [Cuisine]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var labelText: UILabel!
    @IBOutlet weak var cuisineImage: UIImageView!
    
    @IBOutlet weak var navBarBackground: UIView!
    @IBOutlet weak var recipeBg: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        setupQueryCuisine()
        setupTableView()
        tableView.layer.cornerRadius = 7
        labelText.text = cuisine.name
        recipeBg.layer.cornerRadius = 5
        navBarBackground.layer.borderWidth = 1
        navBarBackground.layer.borderColor = AppColors.Black.cgColor
        
        if let url = URL(string: cuisine.imageUrl) {
               let placeholder = UIImage(named: "placeholder")
               let options : KingfisherOptionsInfo = [KingfisherOptionsInfoItem.transition(.fade(0.1))]
               cuisineImage.kf.indicatorType = .activity
                cuisineImage.kf.setImage(with: url, placeholder: placeholder, options: options)
        }
        
        cuisineImage.layer.opacity = 0.7
    }
    

    func setupTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UINib(nibName: Identifiers.RecipeCell, bundle: nil), forCellReuseIdentifier: Identifiers.RecipeCell)

}
    
    override func viewDidAppear(  _ animated: Bool) {
     //  self.navigationController!.navigationBar.isHidden = true
        
    
        }
    
    func setupQueryCuisine() {
          listener = db.recipesCuisines(cuisine: cuisine.id).addSnapshotListener({ (snap, error) in
              if let error = error {
                  debugPrint(error.localizedDescription)
                  return
              }
              
         snap?.documentChanges.forEach({ (change) in
                         let data = change.document.data()
                         let recipe = Recipe.init(data: data)

                         switch change.type {
                         case .added:
                             self.onDocumentAdded(change: change, recipe: recipe)
                         case .modified:
                             self.onDocumentModified(change: change, recipe: recipe)
                         case .removed:
                             self.onDocumentRemoved(change: change)
                         }
                 })
             }
             )
         }
}

extension RecipesCuisinesVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func onDocumentAdded(change: DocumentChange, recipe: Recipe) {
        let newIndex = Int(change.newIndex)
        recipes.insert(recipe, at: newIndex)
        tableView.insertRows(at: [IndexPath(row: newIndex, section: 0)], with: .fade)
    }

    func onDocumentModified(change: DocumentChange, recipe: Recipe) {
        if change.newIndex == change.oldIndex {
            // Item changed, but remained in the same position
            let index = Int(change.newIndex)
            recipes[index] = recipe
            tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
        } else {
            // Item changed and changed position
            let oldIndex = Int(change.oldIndex)
            let newIndex = Int(change.newIndex)
            recipes.remove(at: oldIndex)
            recipes.insert(recipe, at: newIndex)
            tableView.moveRow(at: IndexPath(row: oldIndex, section: 0), to: IndexPath(row: newIndex, section: 0))
        }
    }

    func onDocumentRemoved(change: DocumentChange) {
        let oldIndex = Int(change.oldIndex)
        recipes.remove(at: oldIndex)
        tableView.deleteRows(at: [IndexPath(row: oldIndex, section: 0)], with: .left)
}

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return recipes.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    if let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.RecipeCell, for: indexPath) as? RecipeCell {

    cell.configureCell(recipe: recipes[indexPath.item])
    cell.layer.cornerRadius = 2
    cell.layer.shadowColor = AppColors.Black.cgColor
    cell.layer.shadowOpacity = 0.4
    cell.layer.shadowOffset = CGSize.zero
    cell.layer.shadowRadius = 2


    return cell
}
    return UITableViewCell()
}
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           selectedRecipe = recipes[indexPath.row]
           performSegue(withIdentifier: Segues.ToRecipeDetailsCuisine, sender: self)
       }

       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == Segues.ToRecipeDetailsCuisine {
               if let destination = segue.destination as? RecipeDetailsVC {
                   destination.recipe = selectedRecipe
               }
           }
       }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}
