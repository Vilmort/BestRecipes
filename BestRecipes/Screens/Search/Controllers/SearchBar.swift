//
//  SearchBarViewController.swift
//  Test3
//
//  Created by Vanopr on 28.08.2023.
//

import UIKit

class SearchBar: UIViewController, UISearchBarDelegate {

  var searchBar = UISearchBar()
  var recipes: [Recipe] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    view.translatesAutoresizingMaskIntoConstraints = false
    setupSearchBar()
    setupTextField()
    setConstrains()
  }

  private func setupSearchBar() {
    searchBar.delegate = self
    searchBar.backgroundImage = UIImage()
    searchBar.barTintColor = .white
    searchBar.tintColor = .white
    searchBar.searchTextField.translatesAutoresizingMaskIntoConstraints = false
    searchBar.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(searchBar)

  }

  private func setupTextField() {
    if let searchBarTextField = searchBar.value(forKey: "searchField") as? UITextField {
      searchBarTextField.backgroundColor = .white
      searchBarTextField.textColor = .black
      searchBarTextField.attributedPlaceholder = NSAttributedString(string: "Search Recipe Here", attributes: [.foregroundColor: UIColor.lightGray])
      searchBarTextField.layer.borderColor = UIColor.lightGray.cgColor
      searchBarTextField.layer.borderWidth = 2.0 // Толщина рамки
      searchBarTextField.layer.cornerRadius = 15.0 // Закругление углов рамки
      if let glassIconView = searchBarTextField.leftView as? UIImageView {
        glassIconView.tintColor = .black // Цвет лупы
      }
    }
  }
  private func setConstrains() {
    NSLayoutConstraint.activate([
      view.heightAnchor.constraint(equalToConstant: 40),
      searchBar.topAnchor.constraint(equalTo: view.topAnchor),
      searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      searchBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      searchBar.searchTextField.topAnchor.constraint(equalTo: searchBar.topAnchor),
      searchBar.searchTextField.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor),
      searchBar.searchTextField.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor),
      searchBar.searchTextField.bottomAnchor.constraint(equalTo: searchBar.bottomAnchor)
    ])
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    if let searchTerm = searchBar.text, !searchTerm.isEmpty {
      loadRecipes(searchTerm)
    }
  }

  private func loadRecipes(_ text: String)  {
    Task {
      do {
        let response = try await RecipeAPI.fetchSearch(with: text )
        recipes = response.results
        presentSearchScreen()
      } catch {
        await MainActor.run(body: {
          print(error, error.localizedDescription)
        })
      }
    }
  }

  private func presentSearchScreen() {
    let searchResultsVC = SearchViewController()
    searchResultsVC.recipes = recipes
    searchResultsVC.modalPresentationStyle = .formSheet
    present(searchResultsVC, animated: true, completion: nil)
  }

}
