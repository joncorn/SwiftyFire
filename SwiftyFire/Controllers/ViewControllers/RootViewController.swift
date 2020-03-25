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
    return button
  }()
  
  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    
    setupViews()
    setupAddButton()
  }
  
  // MARK: - Setup Methods
  func setupViews() {
    view.addSubview(addButton)
  }
  
  func setupAddButton() {
    addButton.edgesToSuperview(excluding: .bottom, insets: UIEdgeInsets(top: 32, left: 16, bottom: 0, right: 16), usingSafeArea: true)
    addButton.height(50)
  }
  
}
