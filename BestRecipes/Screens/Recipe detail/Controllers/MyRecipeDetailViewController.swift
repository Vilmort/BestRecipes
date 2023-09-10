//
//  MyRecipeDetailViewController.swift
//  BestRecipes
//
//  Created by Александра Савчук on 26.08.2023.
//

import Foundation
import UIKit

class MyRecipeDetailViewController: UIViewController {
  var recipe: Recipe?
  let navigationBar = CustomNavigationBar()
  var myRecipe: MyRecipe?
  var ingredients: [RowDataCell]?

  private lazy var nameLabel: UILabel = {
    let textLabel = UILabel()
    textLabel.text = ""
    textLabel.textAlignment = .center
    textLabel.font = .poppinsSemiBold(size: 20)
    textLabel.translatesAutoresizingMaskIntoConstraints = false
    return textLabel
  }()

  private lazy var servesLabel: UILabel = {
    let textLabel = UILabel()
    textLabel.text = ""
    textLabel.textAlignment = .left
    textLabel.font = .poppinsSemiBold(size: 15)
    textLabel.textColor = .white
    textLabel.translatesAutoresizingMaskIntoConstraints = false
    return textLabel
  }()

  private lazy var imageFood: UIImageView = {
    let imageFood = UIImageView()
    imageFood.clipsToBounds = true
    imageFood.layer.cornerRadius = 20
    imageFood.contentMode = .scaleAspectFill
    imageFood.image = UIImage(named: "no image 1")
    imageFood.translatesAutoresizingMaskIntoConstraints = false
    return imageFood
  }()

  private lazy var ingridentsLabel: UILabel = {
    let ingridentsLabel = UILabel()
    ingridentsLabel.text = "Ingridents"
    ingridentsLabel.font = .poppinsSemiBold(size: 16)
    ingridentsLabel.translatesAutoresizingMaskIntoConstraints = false
    return ingridentsLabel
  }()

  private lazy var itemLabel: UILabel = {
    let itemLabel = UILabel()
    itemLabel.text = ""
    itemLabel.font = .poppinsRegular(size: 16)
    itemLabel.textAlignment = .right
    itemLabel.translatesAutoresizingMaskIntoConstraints = false
    return itemLabel
  }()

  private lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
  }()

  private lazy var horizontalStackView: UIStackView = {
    let horizontalStackView = UIStackView()
    horizontalStackView.axis = .horizontal
    horizontalStackView.addArrangedSubview(ingridentsLabel)
    horizontalStackView.addArrangedSubview(itemLabel)
    horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
    return horizontalStackView
  }()

  override func viewDidLoad()  {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupNavBar()
    view.addSubview(nameLabel)
    nameLabel.text = myRecipe?.recipeName
    itemLabel.text = "\(ingredients?.count ?? 0) items"
    servesLabel.text = "serves for " + (myRecipe?.serves)! + " | " + (myRecipe?.cookTime)!
    setupImageView()
    view.addSubview(ingridentsLabel)
    view.addSubview(horizontalStackView)
    setupTableView()
    setConstrains()
  }

  private func setupNavBar() {
    navigationBar.titleOfViewLabel.text = ""
    navigationBar.view.translatesAutoresizingMaskIntoConstraints = false
    addChild(navigationBar)
    view.addSubview(navigationBar.view)
    navigationBar.didMove(toParent: self)
  }

  private func setupTableView() {
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(CustomCellRecipe.self, forCellReuseIdentifier: "CustomCellRecipe")
    tableView.separatorStyle = .none
    view.addSubview(tableView)
  }

  private func setupImageView() {
    if let imageData = myRecipe?.recipeImage {
      imageFood.image = UIImage(data: imageData)
    }
    view.addSubview(imageFood)
    imageFood.addSubview(servesLabel)
  }

  private func setConstrains() {
    NSLayoutConstraint.activate([
      navigationBar.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      navigationBar.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      navigationBar.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      navigationBar.view.heightAnchor.constraint(equalToConstant: 50),
      nameLabel.topAnchor.constraint(equalTo: navigationBar.view.bottomAnchor, constant: 10),
      nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      nameLabel.heightAnchor.constraint(equalToConstant: 44),
      imageFood.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
      imageFood.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      imageFood.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      imageFood.heightAnchor.constraint(equalToConstant: 200),
      servesLabel.bottomAnchor.constraint(equalTo: imageFood.bottomAnchor, constant: -10),
      servesLabel.leadingAnchor.constraint(equalTo: imageFood.leadingAnchor, constant: 10),
      servesLabel.trailingAnchor.constraint(equalTo: imageFood.trailingAnchor),
      servesLabel.heightAnchor.constraint(equalToConstant: 44),
      horizontalStackView.topAnchor.constraint(equalTo: imageFood.bottomAnchor,constant: 10),
      horizontalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      horizontalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      horizontalStackView.heightAnchor.constraint(equalToConstant: 50),
      tableView.topAnchor.constraint(equalTo: horizontalStackView.bottomAnchor,constant: 10),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
}

//MARK: - Extension
extension MyRecipeDetailViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCellRecipe", for: indexPath) as! CustomCellRecipe
    cell.dishImageView.image = UIImage(named: "No image")
    cell.descriptionLbl.text = ingredients?[indexPath.row].textField2Text
    cell.titleLbl.text = ingredients?[indexPath.row].textField1Text
    cell.checkmarkImage.isHidden = true
    return cell
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return ingredients?.count ?? 2
  }
}
