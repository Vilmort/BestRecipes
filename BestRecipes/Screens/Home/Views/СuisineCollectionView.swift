//
//  СuisineCollectionView.swift
//  BestRecipes
//
//  Created by Александра Савчук on 01.09.2023.
//

import UIKit

class СuisineCollectionView: UIView {
  
  var collectionView: UICollectionView!
  weak var delegateCollectionDidSelect: CollectionCuisineDidSelectProtocol?
  
  private var categories: [String] = ["Asian", "American", "French", "German", "Greek", "Indian", "Italian", "Japanese", "Mexican", "Thai"]
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureCollection()
    setCollectionDelegates()
    addSubview(collectionView)
    setupConstraints()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Functions
  func configureCollection() {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.backgroundColor = .clear
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.register(СuisineCell.self, forCellWithReuseIdentifier: СuisineCell.identifier)
  }
  
  func setCollectionDelegates() {
    collectionView.dataSource = self
    collectionView.delegate = self
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
}

extension СuisineCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return categories.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: СuisineCell.identifier, for: indexPath) as? СuisineCell else {
      return UICollectionViewCell()
    }
    let category = categories[indexPath.row]
    cell.configureCell(with: category)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 150, height: 200)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let selectedCuisine = categories[indexPath.item].lowercased()
    delegateCollectionDidSelect?.fetchCuisine(cuisine: selectedCuisine)
  }
}

//MARK: - Protocols
protocol CollectionCuisineDidSelectProtocol: AnyObject {
  func fetchCuisine(cuisine: String)
}
