//
//  CuisinesVC.swift
//  eating in
//
//  Created by Imogen Kraak on 31/05/2020.
//  Copyright © 2020 Imogen Kraak. All rights reserved.
//

import UIKit
import Firebase

class CuisinesVC: UIViewController {
    
    @IBOutlet weak var categoriesDotsStack: UIStackView!
    @IBOutlet weak var cuisinesTableView: UICollectionView!

    @IBOutlet weak var navBarBg: UIView!
    
    var db : Firestore!
    var cuisine: Cuisine!
    var cuisines = [Cuisine]()
    var listener : ListenerRegistration!
    var selectedCuisine: Cuisine!
    
    @IBOutlet weak var cuisinesButton: UIButton!
    @IBOutlet weak var favouritesButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
          navBarStyle()
        setupCollectionViewCuisines()

// Do any additional setup after loading the view.
    }
    
    @IBAction func categoriesClicked(_ sender: Any) {
        
               func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                performSegue(withIdentifier: Segues.ToHome, sender: self)
                     }
           }
   
    
    
    
    func navBarStyle() {
    categoriesDotsStack.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        
        navBarBg.layer.borderWidth = 1
        navBarBg.layer.borderColor = AppColors.Black.cgColor
    }
    
     func setupCollectionViewCuisines() {
            cuisinesTableView.delegate = self
            cuisinesTableView.dataSource = self
            cuisinesTableView.register(UINib(nibName: Identifiers.CuisineCell, bundle: nil), forCellWithReuseIdentifier: Identifiers.CuisineCell)
            

    }

    override func viewDidAppear(  _ animated: Bool) { // appears everytime the view is shown - not just the once when app is started like viewDidLoad
   navBarStyle()
  setCusinesListener()
      
        }
    override func viewWillDisappear(_ animated: Bool) {
           listener.remove()
           cuisines.removeAll()
           cuisinesTableView.reloadData()
       }


func setCusinesListener() {
    listener = db.cuisines.addSnapshotListener({ (snap, error) in
          if let error = error {
              debugPrint(error.localizedDescription)
              return
          }
          
          snap?.documentChanges.forEach({ (change) in
              
              let data = change.document.data()
              let cuisine = Cuisine.init(data: data)
              
              switch change.type {
              case .added:
                  self.onDocumentAdded(change: change, cuisine: cuisine)
              case .modified:
                  self.onDocumentModified(change: change, cuisine: cuisine)
              case .removed:
                  self.onDocumentRemoved(change: change)

              }
          })
      })
    }
}

extension CuisinesVC : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.CuisineCell, for: indexPath) as? CuisineCell {
            cell.configureCell(cuisine: cuisines[indexPath.item])
            return cell
        }
        return UICollectionViewCell()
    }

func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return cuisines.count
}
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width
        let cellWidth = (width - 20) / 5
        
        let cellHeight = cellWidth * 1
        
        return CGSize(width: cellWidth, height: cellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCuisine = cuisines[indexPath.item]
        performSegue(withIdentifier: Segues.ToRecipesAgain, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.ToRecipesAgain {
            if let destination = segue.destination as?
                RecipesCuisinesVC {
                destination.cuisine = selectedCuisine
            }
        }
    }



func onDocumentAdded(change: DocumentChange, cuisine: Cuisine) {
         let newIndex = Int(change.newIndex)
         cuisines.insert(cuisine, at: newIndex)
         cuisinesTableView.insertItems(at: [IndexPath(item: newIndex, section: 0)])
     }
     
     func onDocumentModified(change: DocumentChange, cuisine: Cuisine) {
         if change.newIndex == change.oldIndex {
             // Item changed, but remained in the same position
             let index = Int(change.newIndex)
             cuisines[index] = cuisine
             cuisinesTableView.reloadItems(at: [IndexPath(item: index, section: 0)])
         } else {
             // Item changed and changed position
             let oldIndex = Int(change.oldIndex)
             let newIndex = Int(change.newIndex)
             cuisines.remove(at: oldIndex)
             cuisines.insert(cuisine, at: newIndex)
             
             cuisinesTableView.moveItem(at: IndexPath(item: oldIndex, section: 0), to: IndexPath(item: newIndex, section: 0))
         }
     }
     
     func onDocumentRemoved(change: DocumentChange) {
         let oldIndex = Int(change.oldIndex)
         cuisines.remove(at: oldIndex)
         cuisinesTableView.deleteItems(at: [IndexPath(item: oldIndex, section: 0)])
     }

  }
