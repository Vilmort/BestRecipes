//
//  ShopingListViewController.swift
//  BestRecipes
//
//  Created by Александра Савчук on 31.08.2023.
//

import UIKit

class ShopingListViewController: UIViewController {

  private let customCellIdentifier = "CustomShopListCell"
  var selectedIngredients = SelectedIngredientsManager.shared.selectedIngredients

  // MARK: - User Interface
  private lazy var textLabel = UILabel.makeLabel(text: "Shopping List", font: .poppinsSemiBold(size: 24), textColor: .darkGray)

  private lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.register(CustomShopListCell.self, forCellReuseIdentifier: customCellIdentifier)
    tableView.dataSource = self
    tableView.delegate = self
    tableView.backgroundColor = .neutral10
    tableView.rowHeight = 80
    tableView.isScrollEnabled = true
    tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
  }()

  private lazy var clearButton: UIButton = {
    let button = UIButton()
    button.setTitleColor(.white, for: .normal)
    button.setTitle("Clear Shopping List", for: .normal)
    button.backgroundColor = .primary50
    button.layer.cornerRadius = 28
    button.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
    button.isUserInteractionEnabled = true
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    setupConstraints()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    selectedIngredients = SelectedIngredientsManager.shared.selectedIngredients
    tableView.reloadData()
  }

  @objc private func clearButtonTapped() {
    selectedIngredients.removeAll()
    SelectedIngredientsManager.shared.selectedIngredients.removeAll()
    tableView.reloadData()
  }
}

// MARK: - Extension for setUp view constraints

extension ShopingListViewController {
  
  private func setupView() {
    view.backgroundColor = .white
    view.addSubview(textLabel)
    view.addSubview(tableView)
    view.addSubview(clearButton)
    textLabel.textAlignment = .center
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      textLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

      tableView.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 10),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      tableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.63),

      clearButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
      clearButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
      clearButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 10),
      clearButton.heightAnchor.constraint(equalToConstant: 56)
    ])
  }

  private func getImage(_ image: String,at imageView: UIImageView) {
    if let imageURL = URL(string: image) {
      RecipeAPI.loadImageFromURL(urlString: imageURL.absoluteString) { image in
        DispatchQueue.main.async {
          imageView.image = image
        }
      }
    }
  }
}

// MARK: - Extensions for tableView

extension ShopingListViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    selectedIngredients.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: customCellIdentifier, for: indexPath) as! CustomShopListCell

    let ingredient = selectedIngredients[indexPath.row]
    let imageString = "https://spoonacular.com/cdn/ingredients_100x100/\(ingredient.image)"
    cell.setDataIntocell(
      name: ingredient.name,
      amount: ingredient.amount)
    DispatchQueue.main.async {
      self.getImage(imageString, at: cell.ingrImageView)
    }
    return cell
  }

  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let action = UIContextualAction(style: .destructive, title: "Удалить") { _, _, _ in

      self.selectedIngredients.remove(at: indexPath.row)
      SelectedIngredientsManager.shared.selectedIngredients.remove(at: indexPath.row)
      self.tableView.beginUpdates()
      self.tableView.deleteRows(at: [indexPath], with: .left)
      self.tableView.endUpdates()
    }

    let configuration = UISwipeActionsConfiguration(actions: [action])
    return configuration
  }
}
