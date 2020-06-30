//
//  UserService.swift
//  eating in
//
//  Created by Imogen Kraak on 25/01/2020.
//  Copyright © 2020 Imogen Kraak. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

let UserService = _UserService()

final class _UserService {
    
    // Variables
    var user = User()
    var favourites = [Recipe]()
    let auth = Auth.auth()
    let db = Firestore.firestore()
    var userListener : ListenerRegistration? = nil
    var favsListener : ListenerRegistration? = nil
    
    var isGuest : Bool {
        
        guard let authUser = auth.currentUser else {
            return true
        }
        if authUser.isAnonymous {
            return true
        } else {
            return false
        }
    }
    
    func getCurrentUser() {
        guard let authUser = auth.currentUser else { return }
        
        let userRef = db.collection("users").document(authUser.uid)
        userListener = userRef.addSnapshotListener({ (snap, error) in
            
            if let error = error {
                debugPrint(error.localizedDescription)
                return
            }
            
            guard let data = snap?.data() else { return }
            self.user = User.init(data: data)
        })
        
        let favsRef = userRef.collection("favourites")
        favsListener = favsRef.addSnapshotListener({ (snap, error) in
            
            if let error = error {
                debugPrint(error.localizedDescription)
                return
            }
            
            snap?.documents.forEach({ (document) in
                let favourite = Recipe.init(data: document.data())
                self.favourites.append(favourite)
            })
        })
    }
    
    func favouriteSelected(recipe: Recipe) {
        let favsRef = Firestore.firestore().collection("users").document(user.id).collection("favourites")
        
        if favourites.contains(where: { (recipe) -> Bool in
            true
        }) {
            // We remove it as a favorite
            favourites.removeAll()
            favsRef.document(recipe.id).delete()
        } else {
            // Add as a favorite.
            favourites.append(recipe)
            let data = Recipe.modelToData(recipe: recipe)
            favsRef.document(recipe.id).setData(data)
        }
    }
    
    func logoutUser() {
        userListener?.remove()
        userListener = nil
        favsListener?.remove()
        favsListener = nil
        user = User()
        favourites.removeAll()
    }
}
