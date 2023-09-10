//
//  SeeAllViewController.swift
//  BestRecipes
//
//  Created by Александра Савчук on 26.08.2023.
//

import UIKit

class SeeAllViewController: UIViewController {
  
  let navigationBar = CustomNavigationBar()
  var recipes: [RecipeInfoForCell]!
  var collectionView: SeeAllCollectionView!
  
  init(title: String, recipes: [RecipeInfoForCell]) {
    super.init(nibName: nil, bundle: nil)
    navigationBar.titleOfViewLabel.text = title.capitalized
    self.recipes = recipes
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    setupNavBar()
    setCollectionView()
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
  
  private func setCollectionView() {
    collectionView = SeeAllCollectionView(frame: .zero, navController: navigationController!, recipes: recipes)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    self.view.addSubview(collectionView)
    
    NSLayoutConstraint.activate([
      collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
      collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
      collectionView.topAnchor.constraint(equalTo: navigationBar.view.bottomAnchor),
      collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
    ])
  }
}
