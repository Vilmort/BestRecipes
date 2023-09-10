//
//  СuisineCell.swift
//  BestRecipes
//
//  Created by Александра Савчук on 01.09.2023.
//

import UIKit

class СuisineCell: UICollectionViewCell {

  static let identifier = "СuisineCell"

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
    setupConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  //MARK: - Outlets

  private let dishImageView = UIImageView.makeImage(cornerRadius: 70)
  private let titleLabel = UILabel.makeLabelForCells(text: "How to make sharwama at home", font: .poppinsSemiBold(size: 16), textColor: .black)

  //MARK: - Functions

  public func configureCell(with title: String) {
    DispatchQueue.main.async {
      self.titleLabel.text = title
      self.dishImageView.image = UIImage(named: title.lowercased())
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
      dishImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      dishImageView.heightAnchor.constraint(equalToConstant: 150),
      dishImageView.widthAnchor.constraint(equalToConstant: 150),

      titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      titleLabel.topAnchor.constraint(equalTo: dishImageView.bottomAnchor, constant: 10),
    ])
  }
}
