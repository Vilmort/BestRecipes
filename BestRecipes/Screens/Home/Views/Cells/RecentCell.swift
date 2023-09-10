//
//  RecentCell.swift
//  BestRecipes
//
//  Created by Александра Савчук on 01.09.2023.
//

import UIKit
import Kingfisher

class RecentCell: UICollectionViewCell {
  
  var currentRecipe: RecipeInfoForCell?
  static let identifier = "RecentCell"
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .white
    setupViews()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Outlets
  
  private let dishImageView = UIImageView.makeImage(cornerRadius: 20)
  private let titleLabel = UILabel.makeLabelForCells(text: "How to make sharwama at home", font: .poppinsSemiBold(size: 16), textColor: .black)
  
  //MARK: - Functions
  let options: KingfisherOptionsInfo = [
    .cacheOriginalImage
  ]
  
  public func configureCell(_ data: RecipeInfoForCell) {
    DispatchQueue.main.async {
      self.titleLabel.text = data.title
      self.dishImageView.kf.setImage(with: URL(string: data.image), options: self.options)
      self.currentRecipe = data
    }
  }
  
  private func setupViews() {
    contentView.addSubview(dishImageView)
    contentView.addSubview(titleLabel)
  }
  
  //MARK: - Constraints
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      dishImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      dishImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      dishImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      dishImageView.heightAnchor.constraint(equalToConstant: 150),
      
      titleLabel.leadingAnchor.constraint(equalTo: dishImageView.leadingAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: dishImageView.trailingAnchor),
      titleLabel.topAnchor.constraint(equalTo: dishImageView.bottomAnchor, constant: 10)
    ])
  }
}
