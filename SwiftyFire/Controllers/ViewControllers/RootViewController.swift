//
//  RootViewController.swift
//  SwiftyFire
//
//  Created by Jon Corn on 3/25/20.
//  Copyright © 2020 Jon Corn. All rights reserved.
//

import UIKit
import Firebase
import TinyConstraints

class RootViewController: UIViewController {
  
  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    
    setupViews()
    setupButtons()
  }
  
  // MARK: - View Elements
  // Add Button
  lazy var addButton: PurpleButton = {
    let button = PurpleButton(title: "Add")
    button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    return button
  }()
  
  // Update Button
  lazy var updateButton: PurpleButton = {
    let button = PurpleButton(title: "Update")
    button.addTarget(self, action: #selector(updateButtonTapped), for: .touchUpInside)
    return button
  }()
  
  // MARK: - Setup Views
  
  // Add button to view
  func setupViews() {
    view.addSubview(addButton)
    view.addSubview(updateButton)
  }
  
  // Set up button constraints
  func setupButtons() {
    addButton.edgesToSuperview(excluding: .bottom, insets: UIEdgeInsets(top: 32, left: 16, bottom: 0, right: 16), usingSafeArea: true)
    addButton.height(50)
    
    updateButton.topToBottom(of: addButton, offset: 8)
    updateButton.left(to: addButton)
    updateButton.right(to: addButton)
    updateButton.height(50)
  }
  
  // MARK: - regular button method
  /**
   Adds `add data`, `merge data`, `add document`, `documentID reference`, and `add user` functionality
   */
  @objc fileprivate func buttonTapped() {
    print("Button Pressed")
    
    // MARK:  Add data
    // accessing root directory in firestore database
    FirestoreReferenceManager.root
      .collection(FirebaseKeys.CollectionPath.cities)
      .document("LA")
      .setData(["name": "Los Angeles",
                "state": "CA",
                "country": "USA",
                "favorites": ["food": "Pizza", "color": "Blue", "subject": "Recess"],]) { (error) in
                  if let error = error {
                    print(error, error.localizedDescription)
                  }
                  print("successfully set data")
    }
    
    // MARK:  Merge data
    let cityData = [
      "name": "Los Angeles New"
    ]
    
    FirestoreReferenceManager.root
      .collection(FirebaseKeys.CollectionPath.cities)
      .document("LA")
      // using the "merge" option with completion will merge instead of replace
      .setData(cityData, merge: true) { (error) in
        if let error = error {
          print(error.localizedDescription)
        }
        print("Successfully merged new data")
    }
    
    // MARK:  Add document
    let newCityData = [
      "name": "Tokyo",
      "country": "Japan"
    ]
    
    // Adding new data to our "city" collection
    FirestoreReferenceManager.root
      .collection(FirebaseKeys.CollectionPath.cities)
      .addDocument(data: newCityData) { (error) in
      if let error = error {
        print(error.localizedDescription)
      }
      print("Successfully set new city data")
    }
    
    // Create a document reference with an auto-generated ID, then use the reference later
    // MARK:  DocumentID reference
    let ref = FirestoreReferenceManager.root.collection(FirebaseKeys.CollectionPath.cities).document()
    let documentID = ref.documentID
    
    let newestCityData = [
      "name": "Berlin",
      "country": "Germany",
      "uid": documentID
    ]
    
    ref.setData(newestCityData, merge: true) { (error) in
      if let error = error {
        print(error.localizedDescription)
      }
      print("Successfully set newest city data")
    }
    
    // MARK:  Add user
    let reference = FirestoreReferenceManager.root.collection(FirebaseKeys.CollectionPath.users).document()
    let uid = reference.documentID
    let userData = [
      "uid": uid,
      "name": "Bob"
    ]
    
    FirestoreReferenceManager.referenceForUserPublicData(uid: uid).setData(userData, merge: true) { (error) in
      if let error = error {
        print(error.localizedDescription)
      }
      print("Successfully set user data")
    }
  }
  
  // MARK: - update button method
  @objc fileprivate func updateButtonTapped() {
    
    // To update some fields of a document without overwriting the entire document, use the update() method
    let ref = FirestoreReferenceManager
      .root
      .collection(FirebaseKeys.CollectionPath.cities)
      .document("LA")
    
    ref.updateData(["name": "Los Angeles Updated",
                    "favorites.color": "Red",
                    "updatedAt": FieldValue.serverTimestamp(),
                    "regions": FieldValue.arrayRemove(["greater_virginia"])]) { (error) in
//                    "regions": FieldValue.arrayUnion(["greater_virginia"])]) { (error) in
      if let error = error {
        print(error.localizedDescription)
      }
      print("Successfully updated data")
    }
  }
}
