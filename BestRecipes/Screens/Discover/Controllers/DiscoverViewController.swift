//
//  DiscoverViewController.swift
//  BestRecipes
//
//  Created by Александра Савчук on 26.08.2023.
//

import UIKit

class DiscoverViewController: UIViewController {

  var collectionView = DiscoverCollectionView()
  var mainLabel = UILabel.makeLabelForCells(text: "Saved recipes", font: .poppinsSemiBold(size: 24), textColor: .neutral100)

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    setupCollectionView()
    setConstraints()
    reloadFavouriteRecipes()
    collectionView.delegate = self
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    reloadFavouriteRecipes()
  }

  func reloadFavouriteRecipes() {
    collectionView.reloadData()
  }

  private func setupCollectionView() {
    view.addSubview(collectionView)
    view.addSubview(mainLabel)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
  }

  private func setConstraints() {
    NSLayoutConstraint.activate([
      mainLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      mainLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      mainLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),

      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      collectionView.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 10),
      collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
    ])
  }
}

//MARK: - Extension
extension DiscoverViewController: DiscoverCollectionDidSelectProtocol {
  func didSelectRecipe(_ recipe: Recipe) {
    SaveToCoreData.saveRecentArrayToCoreData(recipe.id)
    let recipeDetailsVC = RecipeDetailView()
    recipeDetailsVC.recipe = recipe
    recipeDetailsVC.modalPresentationStyle = .fullScreen
    present(recipeDetailsVC, animated: true, completion: nil)
  }
}
