//
//  CustomCellRecipe2.swift
//  BestRecipes
//
//  Created by Тимур on 29.08.2023.
//

import UIKit

class CustomCellRecipe: UITableViewCell {

  private var whiteBackgroundView = UIView.makeView(backgroundColor: .white, cornerRadius: 5)
  
  var dishImageView: UIImageView = {
    let dishImageView = UIImageView()
    dishImageView.clipsToBounds = true
    dishImageView.contentMode = .scaleAspectFit
    dishImageView.layer.cornerRadius = 5
    dishImageView.translatesAutoresizingMaskIntoConstraints = false
    return dishImageView
  }()
  
  var titleLbl: UILabel = {
    let titleLbl = UILabel()
    titleLbl.contentMode = .left
    titleLbl.font = .poppinsSemiBold(size: 16)
    titleLbl.numberOfLines = 3
    titleLbl.text = "Label"
    titleLbl.translatesAutoresizingMaskIntoConstraints = false
    return titleLbl
  }()

  var descriptionLbl: UILabel = {
    let descriptionLbl = UILabel()
    descriptionLbl.contentMode = .left
    descriptionLbl.font = .poppinsSemiBold(size: 16)
    descriptionLbl.text = "Label"
    descriptionLbl.textAlignment = .right
    descriptionLbl.textColor = UIColor.systemGray
    descriptionLbl.translatesAutoresizingMaskIntoConstraints = false
    return descriptionLbl
  }()

  var stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.backgroundColor = UIColor(white: 0, alpha: 0)
    stackView.distribution = .fillEqually
    stackView.axis = .horizontal
    stackView.alignment = .center
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()

  var viewCardView: UIView = {
    let viewCardView = UIView()
    viewCardView.backgroundColor = .neutral10
    viewCardView.layer.cornerRadius = 10
    viewCardView.translatesAutoresizingMaskIntoConstraints = false
    return viewCardView
  }()

    let checkmarkImage: UIImageView = {
    let checkmarkImage = UIImageView()
    checkmarkImage.contentMode = .scaleAspectFit
    checkmarkImage.image = UIImage(systemName: "cart.fill.badge.plus")
    checkmarkImage.tintColor = UIColor.black
    checkmarkImage.translatesAutoresizingMaskIntoConstraints = false
    return checkmarkImage
  }()


  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: "CustomCellRecipe")
    setupUI()
    setupLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("Please use this class from code.")
  }

  private func setupUI() {

    contentView.addSubview(viewCardView)
    viewCardView.addSubview(whiteBackgroundView)
    viewCardView.addSubview(dishImageView)
    viewCardView.addSubview(stackView)
    viewCardView.addSubview(checkmarkImage)
    stackView.addArrangedSubview(titleLbl)
    stackView.addArrangedSubview(descriptionLbl)
//        contentView.isMultipleTouchEnabled = true
  }

  private func setupLayout() {
    NSLayoutConstraint.activate([
      viewCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      viewCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      viewCardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      viewCardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

      dishImageView.leadingAnchor.constraint(equalTo: viewCardView.leadingAnchor, constant: 16),
      dishImageView.topAnchor.constraint(equalTo: viewCardView.topAnchor, constant: 16),
      dishImageView.bottomAnchor.constraint(equalTo: viewCardView.bottomAnchor, constant: -16),
      dishImageView.widthAnchor.constraint(equalToConstant: 50),
      dishImageView.heightAnchor.constraint(equalToConstant: 50),

      stackView.leadingAnchor.constraint(equalTo: dishImageView.trailingAnchor, constant: 16),
      stackView.topAnchor.constraint(equalTo: viewCardView.topAnchor, constant: 16),
      stackView.trailingAnchor.constraint(equalTo: checkmarkImage.leadingAnchor, constant: -8),
      stackView.bottomAnchor.constraint(equalTo: viewCardView.bottomAnchor, constant: -16),

      checkmarkImage.trailingAnchor.constraint(equalTo: viewCardView.trailingAnchor, constant: -16),
      checkmarkImage.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
      checkmarkImage.widthAnchor.constraint(equalToConstant: 24),
      checkmarkImage.heightAnchor.constraint(equalToConstant: 24),

      whiteBackgroundView.leadingAnchor.constraint(equalTo: dishImageView.leadingAnchor),
      whiteBackgroundView.topAnchor.constraint(equalTo: dishImageView.topAnchor),
      whiteBackgroundView.trailingAnchor.constraint(equalTo: dishImageView.trailingAnchor),
      whiteBackgroundView.bottomAnchor.constraint(equalTo: dishImageView.bottomAnchor)
    ])
  }

  func toggleCheckmark() {
    if checkmarkImage.tintColor == UIColor.black {
      checkmarkImage.tintColor = UIColor.primary50
    } else {
      checkmarkImage.tintColor = UIColor.black
    }
  }
}
