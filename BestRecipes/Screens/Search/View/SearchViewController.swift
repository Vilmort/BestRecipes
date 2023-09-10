//
//  SearchViewController.swift
//  BestRecipes
//
//  Created by Vanopr on 28.08.2023.
//

import UIKit

class SearchViewController: UIViewController  {
  
  let searchTableView = UITableView()
  let navigationBar = CustomNavigationBar()
  var recipes: [Recipe] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupNavBar()
    setupTableView()
    setConstrains()
  }
  
  private func setupTableView() {
    searchTableView.delegate = self
    searchTableView.dataSource = self
    searchTableView.register(SearchTableViewCell.self, forCellReuseIdentifier: "cell")
    view.addSubview(searchTableView)
    searchTableView.translatesAutoresizingMaskIntoConstraints = false
  }
  
  private func setupNavBar() {
    navigationBar.titleOfViewLabel.text = "Search Results"
    navigationBar.view.translatesAutoresizingMaskIntoConstraints = false
    addChild(navigationBar)
    view.addSubview(navigationBar.view)
    navigationBar.didMove(toParent: self)
  }
  
  private func setConstrains() {
    NSLayoutConstraint.activate([
      navigationBar.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      navigationBar.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      navigationBar.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      navigationBar.view.heightAnchor.constraint(equalToConstant: 50),
      searchTableView.topAnchor.constraint(equalTo: navigationBar.view.bottomAnchor),
      searchTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      searchTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      searchTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])
  }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
  // Методы делегата и источника данных таблицы
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if recipes.count > 0 {
      return  recipes.count
    } else {
      return 1
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchTableViewCell
    if recipes.count > 0 {
      cell.configureCell(recipes[indexPath.row])
    } else {
      cell.titleLabel.text = "No recipes"
      
    }
    cell.backgroundColor = .white
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 200
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if recipes.count > 0 {
      let selectedRecipe = recipes[indexPath.item]
      SaveToCoreData.saveRecentArrayToCoreData(selectedRecipe.id)
      // Переход наRecipeDetailsViewController()
      let recipeDetailsVC = RecipeDetailView()
      // Передаем значение на следующий экран
      recipeDetailsVC.recipe = selectedRecipe
      recipeDetailsVC.modalPresentationStyle = .pageSheet
      present(recipeDetailsVC, animated: true, completion: nil)
    }
  }
}
