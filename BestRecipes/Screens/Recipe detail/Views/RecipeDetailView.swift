//
//  RecipeDetailView.swift
//  BestRecipes
//
//  Created by Тимур on 28.08.2023.
//

import UIKit

class RecipeDetailView: UIViewController, UITableViewDataSource, UITableViewDelegate {

  var recipe: Recipe?
  var recipeFromSeeAll: RecipeInfoForCell?
  let navigationBar = CustomNavigationBar()
  var recipeDetail: [RecipeFullInfo]?
  var selectedIngredients: [IngredientModel] = []
  var image: UIImage?
  var isIngredientSelected: [Bool]?
 
  //MARK: - UI elements

  private lazy var scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    return scrollView
  }()

  private let cartButton: UIButton = {
    let cartButton = UIButton()
    cartButton.setTitle("Add to cart", for: .normal)
    cartButton.backgroundColor = .red
    cartButton.layer.cornerRadius = 15
    cartButton.titleLabel?.font = .poppinsSemiBold(size: 20)
    cartButton.titleLabel?.textColor = .white
    cartButton.isEnabled = true
    return cartButton
  }()

  private lazy var stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.alignment = .fill
    stackView.spacing = 10
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()

  private lazy var horizontalStackView: UIStackView = {
    let horizontalStackView = UIStackView()
    horizontalStackView.axis = .horizontal
    horizontalStackView.addArrangedSubview(ingridentsLabel)
    horizontalStackView.addArrangedSubview(itemLabel)
    return horizontalStackView
  }()

  private lazy var textLabel: UILabel = {
    let textLabel = UILabel()
    textLabel.text = ""
    textLabel.textAlignment = .center
    textLabel.font = .poppinsRegular(size: 18)
    textLabel.numberOfLines = 2
    return textLabel
  }()

  private lazy var imageFood: UIImageView = {
    let imageFood = UIImageView()
    imageFood.clipsToBounds = true
    imageFood.layer.cornerRadius = 20
    imageFood.contentMode = .scaleAspectFill
    return imageFood
  }()

  private lazy var likeLabel: UILabel = {
    let likeLabel = UILabel()
    likeLabel.text = ""
    likeLabel.textAlignment = .left
    likeLabel.font = .poppinsRegular(size: 12)
    return likeLabel
  }()

  private lazy var instructionLabel: UILabel = {
    let instructionLabel = UILabel()
    instructionLabel.text = "Instruction"
    instructionLabel.textAlignment = .left
    instructionLabel.font = .poppinsSemiBold(size: 16)
    return instructionLabel
  }()

  private lazy var recipeLabel: UILabel = {
    let recipeLabel = UILabel()
    recipeLabel.text = ""
    recipeLabel.font = .poppinsRegular(size: 14)
    recipeLabel.numberOfLines = 0
    return recipeLabel
  }()

  private lazy var ingridentsLabel: UILabel = {
    let ingridentsLabel = UILabel()
    ingridentsLabel.text = "Ingridents"
    ingridentsLabel.font = .poppinsSemiBold(size: 16)
    return ingridentsLabel
  } ()

  private lazy var itemLabel: UILabel = {
    let itemLabel = UILabel()
    itemLabel.text = ""
    itemLabel.font = .poppinsRegular(size: 16)
    itemLabel.textAlignment = .right

    return itemLabel
  } ()

  private lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
  }()
    
 

  override func viewDidLoad() {
    super.viewDidLoad()
      getRecipeDetail()
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(CustomCellRecipe.self, forCellReuseIdentifier: "CustomCellRecipe")
    tableView.separatorStyle = .none
    setupNavBar()
    subview()
    setupConstraints()
    cartButton.addTarget(self, action: #selector(cartButtonPressed), for: .touchUpInside)
  }
  //MARK: - Gettin Details
  private func getRecipeDetail() {
    if let id = recipe?.id   {
      loadRecipes(with: id)
    }
    if let id = recipeFromSeeAll?.id  {
      loadRecipes(with: id)
    }
  }

  private func loadRecipes(with id: Int)  {
    Task {
      do {
        let response = try await RecipeAPI.fetchFullInfo(id)
        recipeDetail = response
        getImage(recipeDetail?[0].image ?? "" ,at: imageFood)
        setupDetails()
        isIngrSelected()
        self.tableView.reloadData()


      } catch {
        await MainActor.run(body: {
          print(error, error.localizedDescription)
        })
      }
    }
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

  private func setupDetails() {
    textLabel.text = recipeDetail?[0].title
    recipeLabel.text = recipeDetail?[0].instructions.htmlToString
    likeLabel.text = "👍" + " " + "\(recipeDetail?[0].aggregateLikes ?? 0 )"
    itemLabel.text = "\(recipeDetail?[0].extendedIngredients.count ?? 0) items"

  }
    private func isIngrSelected() {
        let count = recipeDetail?[0].extendedIngredients.count ?? 0
         isIngredientSelected = [Bool](repeating: false, count: count)
    }

  //MARK: - Button
  @objc func cartButtonPressed() {
      let array1 = selectedIngredients
      let array2 = SelectedIngredientsManager.shared.selectedIngredients
      let resultArray = array1.filter { !array2.contains($0) }

      SelectedIngredientsManager.shared.selectedIngredients.append(contentsOf: resultArray)
    let shopListVC = ShopingListViewController()
    shopListVC.modalPresentationStyle = .pageSheet
       present(shopListVC, animated: true, completion: nil)
  }

  //MARK: - Add subview func

  private func subview() {
    view.backgroundColor = .white
    view.addSubview(scrollView)
    scrollView.addSubview(stackView)
    stackView.addArrangedSubview(textLabel)
    stackView.addArrangedSubview(imageFood)
    stackView.addArrangedSubview(likeLabel)
    stackView.addArrangedSubview(instructionLabel)
    stackView.addArrangedSubview(ingridentsLabel)
    stackView.addArrangedSubview(recipeLabel)
    stackView.addArrangedSubview(horizontalStackView)
    stackView.addArrangedSubview(tableView)
    stackView.addArrangedSubview(cartButton)
  }

  // MARK: -  Constrains
  func setupConstraints() {
    NSLayoutConstraint.activate([
      navigationBar.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      navigationBar.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      navigationBar.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      navigationBar.view.heightAnchor.constraint(equalToConstant: 50),

      scrollView.topAnchor.constraint(equalTo: navigationBar.view.bottomAnchor),
      scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

      stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 2),
      stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 14),
      stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -14),
      stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

      stackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32),

      tableView.heightAnchor.constraint(equalToConstant: 300),

      textLabel.topAnchor.constraint(equalTo: stackView.topAnchor),
      imageFood.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 5),
      imageFood.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 10),
      imageFood.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -10),
      imageFood.heightAnchor.constraint(equalToConstant: 250),
    ])
  }

  //MARK: - NavigationBar
  private func setupNavBar() {
    navigationBar.titleOfViewLabel.text = ""
    navigationBar.view.translatesAutoresizingMaskIntoConstraints = false
    addChild(navigationBar)
    view.addSubview(navigationBar.view)
    navigationBar.didMove(toParent: self)
  }


  //MARK: - TableView

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

    return recipeDetail?[0].extendedIngredients.count ?? 1
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCellRecipe", for: indexPath) as! CustomCellRecipe
    let recipeIngridients = recipeDetail?[0].extendedIngredients[indexPath.row]

    let imageString = "https://spoonacular.com/cdn/ingredients_100x100/\(recipeIngridients?.image ?? "")"
    cell.titleLbl.text = recipeIngridients?.name
    if let amount = recipeIngridients?.measures.metric.amount {
      let intValue = Int(amount)
      cell.descriptionLbl.text = "\(intValue)g"
    } else {
      cell.descriptionLbl.text = "0g"
    }
    cell.selectionStyle = .none
    DispatchQueue.main.async {
      self.getImage(imageString, at: cell.dishImageView)
    }
      
      if isIngredientSelected?[indexPath.row] ?? false {
          cell.checkmarkImage.tintColor = UIColor.primary50
      } else {
          cell.checkmarkImage.tintColor = UIColor.black
      }
      
    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let recipeIngridients = recipeDetail?[0].extendedIngredients[indexPath.row] {
      let cell = tableView.cellForRow(at: indexPath) as! CustomCellRecipe

      let selectedIngredient = IngredientModel(
        image: recipeIngridients.image ,
        name: recipeIngridients.name ,
        amount: recipeIngridients.measures.metric.amount
      )
        if isIngredientSelected?[indexPath.row] ?? false {
            selectedIngredients.removeAll{$0 == selectedIngredient}
            cell.checkmarkImage.tintColor = UIColor.black
            isIngredientSelected?[indexPath.row] = false

        } else {
            selectedIngredients.append(selectedIngredient)
            cell.checkmarkImage.tintColor = UIColor.primary50
            isIngredientSelected?[indexPath.row] = true
        }

    }
  }
}
