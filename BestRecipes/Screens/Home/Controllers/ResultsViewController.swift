//
//  ResultsViewController.swift
//  BestRecipes
//
//  Created by Александра Савчук on 01.09.2023.
//

import UIKit

class ResultsViewController: UIViewController  {

  let searchTableView = UITableView()
  let navigationBar = CustomNavigationBar()
  var recipes: [Recipe] = []
  var selectedCuisine: String = ""

  init(cuisine: String) {
    super.init(nibName: nil, bundle: nil)
    self.selectedCuisine = cuisine
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupNavBar()
    setupTableView()
    setConstraints()
    fetchCuisine()
  }

  private func setupTableView() {
    searchTableView.delegate = self
    searchTableView.dataSource = self
    searchTableView.register(SearchTableViewCell.self, forCellReuseIdentifier: "cell")
    view.addSubview(searchTableView)
    searchTableView.translatesAutoresizingMaskIntoConstraints = false
  }

  private func setupNavBar() {
    navigationBar.titleOfViewLabel.text = "\(selectedCuisine.uppercased()) cuisine"
    navigationBar.view.translatesAutoresizingMaskIntoConstraints = false
    addChild(navigationBar)
    view.addSubview(navigationBar.view)
    navigationBar.didMove(toParent: self)
  }

  private func setConstraints() {
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

  func fetchCuisine() {
    Task {
      do {
        let data = try await RecipeAPI.fetchCuisine(with: selectedCuisine)
        self.recipes = data.results
        self.searchTableView.reloadData()
      } catch {
        await MainActor.run {
          print(error.localizedDescription)
        }
      }
    }
  }
}

extension ResultsViewController: UITableViewDelegate, UITableViewDataSource {
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
      let recipe = recipes[indexPath.item]
      if let imageURL = URL(string: recipe.image) {
        RecipeAPI.loadImageFromURL(urlString: imageURL.absoluteString) { image in
          DispatchQueue.main.async {
            cell.dishImageView.image = image
            cell.titleLabel.text = recipe.title
          }
        }
      }
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
      let recipeDetailsVC = RecipeDetailView()
      recipeDetailsVC.recipe = selectedRecipe
      recipeDetailsVC.modalPresentationStyle = .pageSheet
      present(recipeDetailsVC, animated: true, completion: nil)
    }
  }
}
