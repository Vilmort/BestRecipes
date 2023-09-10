//
//  View.swift
//  BestRecipes
//
//  Created by Владимир on 30.08.2023.
//

import UIKit

extension UIView {
  func removeAllConstraints() {
    for subview in self.subviews {
      subview.removeConstraints(subview.constraints)
    }
  }

  static func makeView(backgroundColor: UIColor, cornerRadius: CGFloat) -> UIView {
    let view = UIView()
    view.backgroundColor = backgroundColor
    view.layer.cornerRadius = cornerRadius
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }
}

var titleOfView = ""
