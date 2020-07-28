//
//  Firebase+Utils.swift
//  eating in
//
//  Created by Imogen Kraak on 16/01/2020.
//  Copyright © 2020 Imogen Kraak. All rights reserved.
//

import Firebase
import FirebaseFirestore

extension Firestore {
    var categories: Query {
        return collection("categories").order(by: "timeStamp", descending: false)
        
    }
    func recipes(category: String) -> Query {
        return collection("recipes").whereField("category", isEqualTo: category).order(by: "timeStamp", descending: true)

    }
    
    func recipesCuisines(cuisine: String) -> Query {
        return collection("recipes").whereField("cuisine", isEqualTo: cuisine).order(by: "timeStamp", descending: true)
    }
    
    var cuisines: Query {
        return collection("cuisines").order(by: "timeStamp", descending: true)
    }
    var ingredients: CollectionReference {
        return collection("ingredients")
    }
    
    var starters: Query {
        return collection("starters")
    }
    
//    func ingredients(category: String) -> Query {
//        return
//            collection("ingredients").whereField("category", isEqualTo: category).order(by: "timeStamp", descending: true)
//    }
}

extension Auth {
    func handleFireAuthError(error: Error, vc: UIViewController) {
        if let errorCode = AuthErrorCode(rawValue: error._code) {
            let alert = UIAlertController(title: "Error", message: errorCode.errorMessage, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            vc.present(alert, animated: true, completion: nil)
        
        }
    }
}

extension AuthErrorCode {
var errorMessage: String {
    switch self {
    case .emailAlreadyInUse:
        return "The email is already in use with another account. Pick another email!"
    case .userNotFound:
        return "Account not found for the specified user. Please check and try again"
    case .userDisabled:
        return "Your account has been disabled. Please contact support."
    case .invalidEmail, .invalidSender, .invalidRecipientEmail:
        return "Please enter a valid email"
    case .networkError:
        return "Network error. Please try again."
    case .weakPassword:
        return "Your password is too weak. The password must be 6 characters long or more."
    case .wrongPassword:
        return "Your password or email is incorrect."
        
    default:
        return "Sorry, something went wrong."
    }
}
}
