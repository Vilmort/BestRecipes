//
//  ImageView.swift
//  BestRecipes
//
//  Created by Александра Савчук on 07.09.2023.
//

import UIKit

extension UIImageView {
    static func makeImage(named imageName: String = "image", cornerRadius: CGFloat) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = cornerRadius
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
}
