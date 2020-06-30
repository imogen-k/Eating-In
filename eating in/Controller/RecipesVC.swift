//
//  RecipesVC.swift
//  eating in
//
//  Created by Imogen Kraak on 16/01/2020.
//  Copyright © 2020 Imogen Kraak. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Firebase
import Kingfisher

class RecipesVC: UIViewController {


    @IBOutlet weak var tableView: UITableView!
    
// add category image to the top and make the navigation bar opaque


    var recipes = [Recipe]()
    var category: Category!
    var cuisine: Cuisine!
    var listener: ListenerRegistration!
    var db : Firestore!
    var selectedRecipe: Recipe!
    var selectedCategory: Category!
    var categories = [Category]()
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var labelText: UILabel!
    @IBOutlet weak var navBarBackground: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        setupTableView()
        setupQuery()
       // tableView.layer.cornerRadius = 7
        labelText.text = category.name
        navBarBackground.layer.borderWidth = 1
        navBarBackground.layer.borderColor = AppColors.Black.cgColor
        
        
        if let url = URL(string: category.imageUrl) {
               let placeholder = UIImage(named: "placeholder")
               let options : KingfisherOptionsInfo = [KingfisherOptionsInfoItem.transition(.fade(0.1))]
               categoryImage.kf.indicatorType = .activity
                categoryImage.kf.setImage(with: url, placeholder: placeholder, options: options)
        }
   //     self.navigationController!.navigationBar.isHidden = true
        categoryImage.layer.opacity = 0.7
    }

        func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: Identifiers.RecipeCell, bundle: nil), forCellReuseIdentifier: Identifiers.RecipeCell)
        }
    
    

    override func viewDidAppear(  _ animated: Bool) {
     //  self.navigationController!.navigationBar.isHidden = true
        self.navigationItem.leftBarButtonItem?.tintColor = AppColors.White
        
    
        }
        

    func setupQuery() {
        listener = db.recipes(category: category.id).addSnapshotListener({ (snap, error) in
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



extension RecipesVC: UITableViewDelegate, UITableViewDataSource {

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
            //cell.layer.cornerRadius = 2
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
        performSegue(withIdentifier: Segues.ToRecipeDetails, sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.ToRecipeDetails {
            if let destination = segue.destination as? RecipeDetailsVC {
                destination.recipe = selectedRecipe
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
   
    }





