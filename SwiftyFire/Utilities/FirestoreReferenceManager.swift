//
//  FirestoreReferenceManager.swift
//  SwiftyFire
//
//  Created by Jon Corn on 3/25/20.
//  Copyright © 2020 Jon Corn. All rights reserved.
//

import Firebase

struct FirestoreReferenceManager {
  
  // `environment` here refers to the firestore collection and document name
  static let environment = "dev"
  
  static let db = Firestore.firestore()
  static let root = db.collection(environment).document(environment)
}
