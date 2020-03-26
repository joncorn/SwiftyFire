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
  
  // MARK: - View Elements
  lazy var addButton: PurpleButton = {
    let button = PurpleButton(title: "Add")
    button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    return button
  }()
  
  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    
    setupViews()
    setupAddButton()
  }
  
  // MARK: - Setup Views
  func setupViews() {
    view.addSubview(addButton)
  }
  
  func setupAddButton() {
    addButton.edgesToSuperview(excluding: .bottom, insets: UIEdgeInsets(top: 32, left: 16, bottom: 0, right: 16), usingSafeArea: true)
    addButton.height(50)
  }
  
  // MARK: - Methods
  @objc fileprivate func buttonTapped() {
    print("Button Pressed")
    
    // MARK:  Add data
    // accessing root directory in firestore database
    FirestoreReferenceManager.root
      .collection(FirebaseKeys.CollectionPath.cities)
      .document("LA")
      .setData(["name": "Los Angeles",
                "state": "CA",
                "country": "USA"]) { (error) in
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
}
