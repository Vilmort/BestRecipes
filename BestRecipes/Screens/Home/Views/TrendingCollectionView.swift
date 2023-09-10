//
//  TrendingCollectionView.swift
//  BestRecipes
//
//  Created by Александра Савчук on 27.08.2023.
//

import UIKit

class TrendingCollectionView: UIView {
  
  var collectionView: UICollectionView!
  let bookmarksManager = BookmarksManager.shared
  weak var delegate: TrendingCollectionViewDelegate?
  
  var recipes: [Recipe] = [] {
    didSet {
      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
    }
  }
  
  var recipeFullInfo: [RecipeInfoForCell] = [] {
    didSet {
      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    configureCollection()
    setupConstraints()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configureCollection() {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.backgroundColor = .clear
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.register(TrendingCell.self, forCellWithReuseIdentifier: TrendingCell.identifier)
    collectionView.delegate = self
    collectionView.dataSource = self
  }
  
  private func setupConstraints() {
    self.addSubview(collectionView)
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
}

//MARK: - Extensions
extension TrendingCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return recipeFullInfo.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendingCell.identifier, for: indexPath) as? TrendingCell else {
      return UICollectionViewCell()
    }
    let selectedNews = recipeFullInfo[indexPath.row]
    if bookmarksManager.bookmarksArray.contains(selectedNews) {
      cell.liked = true
      cell.favouriteButton.setImage(UIImage(named: "bookmarkSelect"), for: .normal)
    } else {
      cell.favouriteButton.setImage(UIImage(named: "bookmark"), for: .normal)
    }
    cell.configureCell(recipeFullInfo[indexPath.row])
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 230, height: 240)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if recipes.count > 0 {
      let selectedRecipe = recipes[indexPath.item]
      delegate?.didSelectRecipe(selectedRecipe)
    }
  }
}

//MARK: - Protocols
protocol TrendingCollectionViewDelegate: AnyObject {
  func didSelectRecipe(_ recipe: Recipe)
}
