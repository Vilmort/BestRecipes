//
//  CategoryCell.swift
//  BestRecipes
//
//  Created by Александра Савчук on 31.08.2023.
//

import UIKit

class CategoryNameCell: UICollectionViewCell {

  static let identifier = "CategoryCell"
  private let categoryLabel = UILabel.makeLabel(text: "", font: .poppinsSemiBold(size: 14), textColor: .primary20)

  override var isSelected: Bool {
    didSet {
      if isSelected {
        backgroundColor = UIColor.primary50
        categoryLabel.textColor = UIColor.white
      } else {
        backgroundColor = UIColor.white
        categoryLabel.textColor = UIColor.primary20
      }
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
    setupConstraints()
    setupUICell()
  }

  func setupUICell() {
    backgroundColor = .white
    layer.masksToBounds = false
    layer.cornerRadius = 15
    categoryLabel.numberOfLines = 1
    categoryLabel.textAlignment = .center
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public func configure(with title: String) {
    categoryLabel.text = title
  }

  private func setupViews() {
    contentView.addSubview(categoryLabel)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      categoryLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
      categoryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      categoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      categoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
    ])
  }
}
