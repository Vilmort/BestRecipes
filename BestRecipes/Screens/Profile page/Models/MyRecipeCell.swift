
//
//  MyRecipeCell.swift
//  BestRecipes
//
//  Created by Vanopr on 30.08.2023.
//

import Foundation
import UIKit

class MyRecipeCell: UICollectionViewCell {

  var currentRecipe: RecipeInfoForCell?
  let bookmarksManager = BookmarksManager.shared

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
    setupConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  //MARK: - Outlets
  let dishImageView = UIImageView.makeImage(cornerRadius: 20)
  let titleLabel = UILabel.makeLabelForCells(text: "How to make sharwama at home", font: .poppinsSemiBold(size: 16), textColor: .white)
  let minuteLabel = UILabel.makeLabelForCells(text: "15 min", font: .poppinsSemiBold(size: 12), textColor: .white)
  lazy var minuteView = UIView.makeView(backgroundColor: UIColor(red: 0.19, green: 0.19, blue: 0.19, alpha: 0.3), cornerRadius: 8)

  //MARK: - Functions
  private func setupViews() {
    contentView.addSubview(dishImageView)
    contentView.addSubview(titleLabel)
    minuteView.addSubview(minuteLabel)
    contentView.addSubview(minuteView)
    minuteLabel.numberOfLines = 2
  }

  //MARK: - Constraints
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      dishImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      dishImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      dishImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      dishImageView.heightAnchor.constraint(equalToConstant: 200),

      titleLabel.leadingAnchor.constraint(equalTo: dishImageView.leadingAnchor, constant: 10),
      titleLabel.trailingAnchor.constraint(equalTo: dishImageView.trailingAnchor, constant: -10),
      titleLabel.bottomAnchor.constraint(equalTo: minuteView.topAnchor, constant: -5),

      minuteLabel.centerXAnchor.constraint(equalTo: minuteView.centerXAnchor),
      minuteLabel.centerYAnchor.constraint(equalTo: minuteView.centerYAnchor),

      minuteView.leadingAnchor.constraint(equalTo: dishImageView.leadingAnchor, constant: 10),
      minuteView.bottomAnchor.constraint(equalTo: dishImageView.bottomAnchor, constant: -10),
      minuteView.widthAnchor.constraint(equalToConstant: 150),
      minuteView.heightAnchor.constraint(equalToConstant: 20)
    ])
  }
}
