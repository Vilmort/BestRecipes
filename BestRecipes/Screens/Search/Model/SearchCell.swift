//
//  SearchCell.swift
//  Test3
//
//  Created by Vanopr on 28.08.2023.
//
import UIKit
import Kingfisher

class SearchTableViewCell: UITableViewCell {
  
  let dishImageView = UIImageView.makeImage(cornerRadius: 20)
  let titleLabel = UILabel.makeLabel(text: "How to make sharwama at home", font: .poppinsSemiBold(size: 16), textColor: .white)
  let titleBackgroundView = UIView.makeView(backgroundColor: UIColor(white: 0, alpha: 0.7), cornerRadius: 10)
  
  let options: KingfisherOptionsInfo = [
    .cacheOriginalImage
  ]
  
  public func configureCell(_ data: Recipe) {
    DispatchQueue.main.async {
      self.titleLabel.text = data.title
      self.dishImageView.kf.setImage(with: URL(string: data.image), options: self.options)
    }
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    commonInit()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }
  
  private func commonInit() {
    addSubview(dishImageView)
    addSubview(titleBackgroundView)
    addSubview(titleLabel)
    
    dishImageView.translatesAutoresizingMaskIntoConstraints = false
    titleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      dishImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
      dishImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
      dishImageView.heightAnchor.constraint(equalToConstant: 180),
      
      titleBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
      titleBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
      titleBackgroundView.bottomAnchor.constraint(equalTo: dishImageView.bottomAnchor, constant: -10),
      titleBackgroundView.heightAnchor.constraint(equalToConstant: 20),
      
      titleLabel.leadingAnchor.constraint(equalTo: titleBackgroundView.leadingAnchor, constant: 10),
      titleLabel.trailingAnchor.constraint(equalTo: titleBackgroundView.trailingAnchor, constant: -10),
      titleLabel.bottomAnchor.constraint(equalTo: dishImageView.bottomAnchor, constant: -10),
    ])
  }
}
