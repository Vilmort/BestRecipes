//
//  CategoriesCollectionView.swift
//  BestRecipes
//
//  Created by Александра Савчук on 31.08.2023.
//

import UIKit

class CategoriesNames: UIView {
  
  private var collectionView: UICollectionView!
  weak var delegateCollectionDidSelect: CollectionDidSelectProtocol?
  
  private var categories = ["Main course", "Side dish", "Dessert", "Appetizer", "Salad", "Bread", "Breakfast", "Soup", "Beverage", "Sauce", "Marinade", "Fingerfood", "Snack", "Drink"]
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureCollection()
    setCollectionDelegates()
    addSubview(collectionView)
    setupConstraints()
    makeFirstCellActive()
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
    collectionView.register(CategoryNameCell.self, forCellWithReuseIdentifier: CategoryNameCell.identifier)
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
  
  func makeFirstCellActive() {
    let firstIndexPath = IndexPath(item: 0, section: 0)
    collectionView.selectItem(at: firstIndexPath, animated: false, scrollPosition: .centeredHorizontally)
  }
}

extension CategoriesNames: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return categories.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryNameCell.identifier, for: indexPath) as? CategoryNameCell else {
      return UICollectionViewCell()
    }
    let category = categories[indexPath.row]
    cell.configure(with: category)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    let text = categories[indexPath.row]
    let cellWidth = text.size(withAttributes: [.font: UIFont.systemFont(ofSize: 16)]).width + 40
    return CGSize(width: cellWidth, height: 36)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    delegateCollectionDidSelect?.fetchSearch(categoryName: categories[indexPath.item].lowercased())
  }
}

//MARK: - Protocols
protocol CollectionDidSelectProtocol: AnyObject {
  func fetchSearch(categoryName: String)
}
