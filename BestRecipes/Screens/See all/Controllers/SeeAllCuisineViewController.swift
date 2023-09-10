//
//  SeeAllCuisineViewController.swift
//  BestRecipes
//
//  Created by Александра Савчук on 06.09.2023.
//

import UIKit

class SeeAllCuisineViewController: UIViewController {
  
  private var cuisineCollectionView: СuisineCollectionView!
  let navigationBar = CustomNavigationBar()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    navigationBar.titleOfViewLabel.text = "Popular Cuisines"
    setupNavBar()
    setupCollection()
  }
  
  private func setupNavBar() {
    navigationBar.view.translatesAutoresizingMaskIntoConstraints = false
    addChild(navigationBar)
    view.addSubview(navigationBar.view)
    navigationBar.didMove(toParent: self)
    
    NSLayoutConstraint.activate([
      navigationBar.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      navigationBar.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      navigationBar.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      navigationBar.view.heightAnchor.constraint(equalToConstant: 50)
    ])
  }
  
  private func setupCollection() {
    cuisineCollectionView = СuisineCollectionView(frame: .zero)
    cuisineCollectionView.delegateCollectionDidSelect = self
    cuisineCollectionView.backgroundColor = .white
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    cuisineCollectionView.collectionView.showsVerticalScrollIndicator = false
    cuisineCollectionView.collectionView.collectionViewLayout = layout
    cuisineCollectionView.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(cuisineCollectionView)
    
    NSLayoutConstraint.activate([
      cuisineCollectionView.topAnchor.constraint(equalTo: navigationBar.view.bottomAnchor, constant: 40),
      cuisineCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
      cuisineCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
      cuisineCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
}

extension SeeAllCuisineViewController: CollectionCuisineDidSelectProtocol {
  func fetchCuisine(cuisine: String) {
    let resultsViewController = ResultsViewController(cuisine: cuisine)
    self.present(resultsViewController, animated: true, completion: nil)
  }
}
