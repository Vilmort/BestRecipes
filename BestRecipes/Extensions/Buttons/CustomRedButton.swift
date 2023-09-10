//
//  CustomRedButton.swift
//  BestRecipes
//
//  Created by Александра Савчук on 27.08.2023.
//

import UIKit

class CustomRedButton: UIButton {
  var customTitle: String? {
    didSet {
      setTitle(customTitle, for: .normal)
    }
  }

  init(customTitle: String, cornerRadius: CGFloat) {
    super.init(frame: .zero)
    self.customTitle = customTitle
    self.layer.cornerRadius = cornerRadius
    setupButton()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupButton()
  }

  private func setupButton() {
    self.backgroundColor = .primary50
    self.setTitleColor(.white0, for: .normal)
    self.setTitle(customTitle, for: .normal)
    self.titleLabel?.font = .boldSystemFont(ofSize: 24)
    self.translatesAutoresizingMaskIntoConstraints = false
  }
}
