//
//  SeeAllCell.swift
//  BestRecipes
//
//  Created by Владимир on 01.09.2023.
//

import UIKit


class SeeAllCell: TrendingCell {
    
    static let seeAllIdentifier = "SeeAllCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.removeAllConstraints()
        self.contentView.removeAllConstraints()
        self.setupConstraints()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.authorLabel.isHidden = true
        self.authorImageView.isHidden = true
        
        for label in [titleLabel, minuteLabel] {
            label.textColor = .white
            label.text = " " + (label.text ?? "") + " "
            label.backgroundColor = .white.withAlphaComponent(0.4)
            label.layer.cornerRadius = 15
            label.layer.masksToBounds = true
        }
    }
    
    
    
    //MARK: - Constraints For SeeAllVC
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            dishImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            dishImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            dishImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            dishImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            
            whiteCircleView.topAnchor.constraint(equalTo: dishImageView.topAnchor, constant: 8),
            whiteCircleView.trailingAnchor.constraint(equalTo: dishImageView.trailingAnchor,constant: -9),
            whiteCircleView.widthAnchor.constraint(equalToConstant: 32),
            whiteCircleView.heightAnchor.constraint(equalToConstant: 32),
            
            favouriteButton.centerXAnchor.constraint(equalTo: whiteCircleView.centerXAnchor),
            favouriteButton.centerYAnchor.constraint(equalTo: whiteCircleView.centerYAnchor),
            favouriteButton.widthAnchor.constraint(equalToConstant: 32),
            favouriteButton.heightAnchor.constraint(equalToConstant: 32),
            
            minuteLabel.bottomAnchor.constraint(equalTo: dishImageView.bottomAnchor, constant: -5),
            minuteLabel.topAnchor.constraint(equalTo: minuteLabel.bottomAnchor, constant: -25),
            minuteLabel.leftAnchor.constraint(equalTo: dishImageView.leftAnchor, constant: 5),
            minuteLabel.rightAnchor.constraint(equalTo: minuteLabel.leftAnchor, constant: 100),
            
            titleLabel.bottomAnchor.constraint(equalTo: minuteLabel.topAnchor, constant: -5),
//            titleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -100),
            titleLabel.leftAnchor.constraint(equalTo: dishImageView.leftAnchor, constant: 5),
//            titleLabel.rightAnchor.constraint(equalTo: dishImageView.rightAnchor, constant: -5),
            titleLabel.widthAnchor.constraint(lessThanOrEqualTo: dishImageView.widthAnchor, constant: -10),
            
            
            
//            titleLabel.leftAnchor.constraint(equalTo: dishImageView.leftAnchor, constant: 10),
//            titleLabel.rightAnchor.constraint(equalTo: dishImageView.rightAnchor, constant: -10),
//            titleLabel.topAnchor.constraint(equalTo: dishImageView.bottomAnchor, constant: 10),
            
//            authorImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
//            authorImageView.bottomAnchor.constraint(equalTo: authorImageView.topAnchor, constant: 32),
//            authorImageView.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
//            authorImageView.rightAnchor.constraint(equalTo: authorImageView.leftAnchor, constant: 32),
            
//            authorLabel.leadingAnchor.constraint(equalTo: authorImageView.trailingAnchor, constant: 10),
//            authorLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: -10),
//            authorLabel.centerYAnchor.constraint(equalTo: authorImageView.centerYAnchor),
            
//            minuteLabel.centerXAnchor.constraint(equalTo: minuteView.centerXAnchor),
//            minuteLabel.centerYAnchor.constraint(equalTo: minuteView.centerYAnchor),
            
            likesLabel.centerXAnchor.constraint(equalTo: likesView.centerXAnchor),
            likesLabel.centerYAnchor.constraint(equalTo: likesView.centerYAnchor),
            
//            minuteView.leadingAnchor.constraint(equalTo: dishImageView.leadingAnchor, constant: 10),
//            minuteView.bottomAnchor.constraint(equalTo: dishImageView.bottomAnchor, constant: -10),
//            minuteView.widthAnchor.constraint(equalToConstant: 45),
//            minuteView.heightAnchor.constraint(equalToConstant: 20),
            
            likesView.leadingAnchor.constraint(equalTo: dishImageView.leadingAnchor, constant: 10),
            likesView.topAnchor.constraint(equalTo: dishImageView.topAnchor, constant: 10),
            likesView.widthAnchor.constraint(equalToConstant: 58),
            likesView.heightAnchor.constraint(equalToConstant: 21)
        ])
    }
}

