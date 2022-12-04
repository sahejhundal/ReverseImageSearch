//
//  FirebaseManager.swift
//  Restaurants
//
//  Created by DON on 10/23/22.
//

import Foundation
import Firebase
import SwiftUI
import FirebaseStorage

class FirebaseManager: NSObject, ObservableObject{
//    let auth: Auth
    let storage: Storage
//    let firestore: Firestore
    
    static let shared = FirebaseManager()
    
    override init(){
//        self.auth = Auth.auth()
        self.storage = Storage.storage()
//        self.firestore = Firestore.firestore()
        
        super.init()
    }
}
