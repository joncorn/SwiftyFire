//
//  PurpleButton.swift
//  SwiftyFire
//
//  Created by Jon Corn on 3/25/20.
//  Copyright © 2020 Jon Corn. All rights reserved.
//

import UIKit

class PurpleButton: UIButton {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  // MARK:  Initializer
  init(title: String) {
    super.init(frame: .zero)
    backgroundColor = .purple
    setTitle(title, for: .normal)
    setTitleColor(.white, for: .normal)
    titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    layer.cornerRadius = 8
    layer.masksToBounds = true
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
