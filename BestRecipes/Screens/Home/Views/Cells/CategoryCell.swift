//
//  CategoryCell.swift
//  BestRecipes
//
//  Created by Александра Савчук on 31.08.2023.
//

import UIKit
import Kingfisher

class CategoryCell: UICollectionViewCell {

  static let identifier = "CategoryCell"
  var liked: Bool = false
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

  private let grayBackgroundView = UIView.makeView(backgroundColor: .neutral10, cornerRadius: 20)
  private let whiteCircleView = UIView.makeView(backgroundColor: .white, cornerRadius: 17)
  private let dishImageView = UIImageView.makeImage(cornerRadius: 50)
  private let titleLabel = UILabel.makeLabelForCells(text: "How to make sharwama at home", font: .poppinsSemiBold(size: 16), textColor: .black)
  private let minuteLabel = UILabel.makeLabelForCells(text: "15 min", font: .poppinsSemiBold(size: 12), textColor: .neutral100)
  private let timeLabel = UILabel.makeLabelForCells(text: "Time", font: .poppinsRegular(size: 12), textColor: .neutral30)

  lazy var favouriteButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(named: "bookmark"), for: .normal)
    button.addTarget(self, action: #selector(favouriteButtonPressed), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  //MARK: - Functions
  @objc func favouriteButtonPressed() {
    if liked {
      favouriteButton.setImage(UIImage(named: "bookmark"), for: .normal)
      liked = false
      bookmarksManager.bookmarksArray.removeAll { $0 == currentRecipe }
    } else {
      favouriteButton.setImage(UIImage(named: "bookmarkSelect"), for: .normal)
      liked = true
      bookmarksManager.bookmarksArray.append(currentRecipe!)
    }
  }

  let options: KingfisherOptionsInfo = [
    .cacheOriginalImage
  ]

  public func configureCell(_ data: RecipeInfoForCell) {
    DispatchQueue.main.async {
      self.titleLabel.text = data.title
      self.dishImageView.kf.setImage(with: URL(string: data.image), options: self.options)
      self.minuteLabel.text = String(data.readyInMinutes) + " " + "min"
      self.currentRecipe = data
    }
  }

  private func setupViews() {
    contentView.addSubview(grayBackgroundView)
    contentView.addSubview(dishImageView)
    contentView.addSubview(titleLabel)
    contentView.addSubview(timeLabel)
    contentView.addSubview(minuteLabel)
    whiteCircleView.addSubview(favouriteButton)
    contentView.addSubview(whiteCircleView)
  }

  //MARK: - Constraints
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      grayBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      grayBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      grayBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      grayBackgroundView.heightAnchor.constraint(equalToConstant: 150),

      dishImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      dishImageView.centerYAnchor.constraint(equalTo: grayBackgroundView.topAnchor),
      dishImageView.centerXAnchor.constraint(equalTo: grayBackgroundView.centerXAnchor),
      dishImageView.heightAnchor.constraint(equalToConstant: 100),
      dishImageView.widthAnchor.constraint(equalToConstant: 100),

      whiteCircleView.bottomAnchor.constraint(equalTo: grayBackgroundView.bottomAnchor, constant: -8),
      whiteCircleView.trailingAnchor.constraint(equalTo: grayBackgroundView.trailingAnchor,constant: -8),
      whiteCircleView.widthAnchor.constraint(equalToConstant: 32),
      whiteCircleView.heightAnchor.constraint(equalToConstant: 32),

      favouriteButton.centerXAnchor.constraint(equalTo: whiteCircleView.centerXAnchor),
      favouriteButton.centerYAnchor.constraint(equalTo: whiteCircleView.centerYAnchor),
      favouriteButton.widthAnchor.constraint(equalToConstant: 32),
      favouriteButton.heightAnchor.constraint(equalToConstant: 32),

      titleLabel.centerXAnchor.constraint(equalTo: grayBackgroundView.centerXAnchor),
      titleLabel.topAnchor.constraint(equalTo: dishImageView.bottomAnchor, constant: 10),
      titleLabel.leadingAnchor.constraint(equalTo: grayBackgroundView.leadingAnchor, constant: 8),
      titleLabel.trailingAnchor.constraint(equalTo: grayBackgroundView.trailingAnchor, constant: -8),
      titleLabel.heightAnchor.constraint(equalToConstant: 30),

      minuteLabel.leadingAnchor.constraint(equalTo: grayBackgroundView.leadingAnchor, constant: 10),
      minuteLabel.bottomAnchor.constraint(equalTo: grayBackgroundView.bottomAnchor, constant: -10),

      timeLabel.leadingAnchor.constraint(equalTo: grayBackgroundView.leadingAnchor, constant: 10),
      timeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
      timeLabel.widthAnchor.constraint(equalToConstant: 45),
      timeLabel.heightAnchor.constraint(equalToConstant: 20),
    ])
  }
}
