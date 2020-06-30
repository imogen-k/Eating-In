//
//  ViewController.swift
//  eating in
//
//  Created by Imogen Kraak on 16/01/2020.
//  Copyright © 2020 Imogen Kraak. All rights reserved.
//

import UIKit
import Firebase

class HomeVC: UIViewController {
    
   
    @IBOutlet weak var loginOutBtn: UIBarButtonItem!
    
    @IBOutlet weak var collectionViewCategories: UICollectionView!
    
    @IBOutlet weak var categoriesButton: UILabel!
    @IBOutlet weak var categoriesStack: UIStackView!
    @IBOutlet weak var navBar: UIView!
    @IBOutlet weak var navBarBackground: UIView!
    @IBOutlet weak var cuisinesButton: UIButton!
    @IBOutlet weak var favouritesButton: UIButton!
    
    @IBOutlet weak var categoriesDotsStack: UIStackView!
    var category: Category!
    var categories = [Category]()
    var selectedCategory: Category!
    var db : Firestore!
    var listener : ListenerRegistration!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        setupCollectionViewCategories()
        setupInitialAnonymousUser()
        navBarStyle()
        
    }
    
    func navBarStyle() {
        categoriesDotsStack.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
      //  navBar.layer.cornerRadius = 5
//        navBar.layer.shadowColor = AppColors.Orange.cgColor
//        navBar.layer.shadowRadius = 20
//        navBar.layer.shadowOffset = .zero
//        
        navBarBackground.layer.borderWidth = 1
        navBarBackground.layer.borderColor = AppColors.Black.cgColor
        self.navigationController!.navigationBar.barStyle = .black
    }
    
    @IBAction func cuisinesClicked(_ sender: Any) {
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                  performSegue(withIdentifier: Segues.ToCuisines, sender: self)
              }
    }
    
    
    

    
    
    
       func setupCollectionViewCategories() {
        collectionViewCategories.delegate = self
        collectionViewCategories.dataSource = self
        collectionViewCategories.register(UINib(nibName: Identifiers.CategoryCell, bundle: nil), forCellWithReuseIdentifier: Identifiers.CategoryCell)
        
        

}
    
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
        
    }

    func setupInitialAnonymousUser() {
       if Auth.auth().currentUser == nil {
            Auth.auth().signInAnonymously { (result, error) in
                if let error = error {
                    Auth.auth().handleFireAuthError(error: error, vc: self)
                    debugPrint(error)
                
                }
            }
        }
    }
    
    override func viewDidAppear(  _ animated: Bool) { // appears everytime the view is shown - not just the once when app is started like viewDidLoad
        setCategoriesListener()
        navBarStyle()
        
       
        
        if let user = Auth.auth().currentUser, !user.isAnonymous {
        loginOutBtn.title = "Logout"
        
        } else {
            loginOutBtn.title = "Login"
        }
       }
    override func viewWillDisappear(_ animated: Bool) {
        listener.remove()
        categories.removeAll()
        collectionViewCategories.reloadData()
    }
    
    func setCategoriesListener() {
        listener = db.categories.addSnapshotListener({ (snap, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
                return
            }
            
            snap?.documentChanges.forEach({ (change) in
                
                let data = change.document.data()
                let category = Category.init(data: data)
                
                switch change.type {
                case .added:
                    self.onDocumentAdded(change: change, category: category)
                case .modified:
                    self.onDocumentModified(change: change, category: category)
                case .removed:
                    self.onDocumentRemoved(change: change)

                }
            })
        })
       }

    fileprivate func presentLoginController() {
        let storyboard = UIStoryboard(name: Storyboard.LoginStoryboard, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: StoryboardId.loginVC)
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        guard let user = Auth.auth().currentUser else { return }
        if user.isAnonymous {
            presentLoginController()
        } else {
            do {
                try Auth.auth().signOut()
                Auth.auth().signInAnonymously { (result, error) in
                    if let error = error {
                        Auth.auth().handleFireAuthError(error: error, vc: self)
                        debugPrint(error)
                    }
                    self.presentLoginController()
                } } catch {
                    Auth.auth().handleFireAuthError(error: error, vc: self)
                    debugPrint(error)
            }
        }
    }
    
}
    
    
    

extension HomeVC : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.CategoryCell, for: indexPath) as? CategoryCell {
            cell.configureCell(category: categories[indexPath.item])
                return cell
        }
            return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width
        let cellWidth = (width - 10) / 3
        let cellHeight = cellWidth * 1
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCategory = categories[indexPath.item]
        performSegue(withIdentifier: Segues.ToRecipes, sender: self)
    }
    
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//           performSegue(withIdentifier: Segues.ToCuisines, sender: self)
//       }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.ToRecipes {
            if let destination = segue.destination as? RecipesVC {
                destination.category = selectedCategory
            }
        
        }
    }
    
    

    
     func onDocumentAdded(change: DocumentChange, category: Category) {
           let newIndex = Int(change.newIndex)
           categories.insert(category, at: newIndex)
           collectionViewCategories.insertItems(at: [IndexPath(item: newIndex, section: 0)])
       }
       
       func onDocumentModified(change: DocumentChange, category: Category) {
           if change.newIndex == change.oldIndex {
               // Item changed, but remained in the same position
               let index = Int(change.newIndex)
               categories[index] = category
               collectionViewCategories.reloadItems(at: [IndexPath(item: index, section: 0)])
           } else {
               // Item changed and changed position
               let oldIndex = Int(change.oldIndex)
               let newIndex = Int(change.newIndex)
               categories.remove(at: oldIndex)
               categories.insert(category, at: newIndex)
               
               collectionViewCategories.moveItem(at: IndexPath(item: oldIndex, section: 0), to: IndexPath(item: newIndex, section: 0))
           }
       }
       
       func onDocumentRemoved(change: DocumentChange) {
           let oldIndex = Int(change.oldIndex)
           categories.remove(at: oldIndex)
           collectionViewCategories.deleteItems(at: [IndexPath(item: oldIndex, section: 0)])
       }
  
    }
