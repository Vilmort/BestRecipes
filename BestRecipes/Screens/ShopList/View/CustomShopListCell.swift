//
//  CustomShopListCell.swift
//  BestRecipes
//
//  Created by Анастасия Рыбакова on 03.09.2023.
//

import UIKit

class CustomShopListCell: UITableViewCell {

  // MARK: - User Interface

  var ingrImageView = UIImageView.makeImage(cornerRadius: 5)
  private lazy var ingrNameLabel = UILabel.makeLabel(font: .poppinsRegular(size: 16), textColor: .black)
  private lazy var ingrAmountLabel =  UILabel.makeLabel(font: .poppinsRegular(size: 16), textColor: .black)

  // MARK: - Override required methodes
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.setupCell()
    self.setupConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - methode to put information into the cell
  func setDataIntocell(name: String, amount: Double) {
    ingrNameLabel.text = name
    ingrAmountLabel.text = "\(Int(amount))g"
  }
}

// MARK: - extensions _ setup cell and constraints
extension CustomShopListCell {

  private func setupCell() {
    ingrAmountLabel.textAlignment = .left
    ingrNameLabel.textAlignment = .left
    ingrNameLabel.numberOfLines = 2
    ingrImageView.contentMode = .scaleAspectFit
    self.backgroundColor = .neutral10
    self.addSubview(ingrImageView)
    self.addSubview(ingrNameLabel)
    self.addSubview(ingrAmountLabel)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      ingrImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
      ingrImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
      ingrImageView.heightAnchor.constraint(equalToConstant: 60),
      ingrImageView.widthAnchor.constraint(equalToConstant: 60),

      ingrAmountLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
      ingrAmountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

      ingrNameLabel.leadingAnchor.constraint(equalTo: ingrImageView.trailingAnchor, constant: 10),
      ingrNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
      ingrNameLabel.trailingAnchor.constraint(equalTo: ingrAmountLabel.leadingAnchor, constant: -20),
    ])
  }
}
