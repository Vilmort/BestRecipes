//
//  CreateRecipeViewController.swift
//  BestRecipes
//
//  Created by Александра Савчук on 26.08.2023.
//

import UIKit

class CreateRecipeViewController: UIViewController {

  private let navigationBar = CustomNavigationBar()
  private let collectionView = MyRecipeCollectionView()
  private let imagePicker = UIImagePickerController()
  private let imageEdit = UIImageView.init(image: UIImage(named: "Edit"))

  private var dishImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "No image 1")
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.isUserInteractionEnabled = true
    imageView.layer.borderColor = UIColor.lightGray.cgColor
    imageView.layer.borderWidth = 2
    imageView.layer.cornerRadius = 20
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  private let nameTextField: UITextField = {
    let textField = UITextField()
    textField.placeholder = "Recipe Name"
    textField.borderStyle = .roundedRect
    textField.layer.cornerRadius = 10
    textField.layer.borderWidth = 1.0
    textField.layer.borderColor = UIColor.red.cgColor
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.returnKeyType = .done
    textField.backgroundColor = .white
    return textField
  }()

  private let servingPicker = ServingPickerView()
  private let cookTimePicker = CookTimePickerView()
  private let ingredientsLabel = UILabel.makeLabelForCells(text: "Ingredients", font: .poppinsSemiBold(size: 20), textColor: .neutral100)

  private let createButton: UIButton = {
    let button = UIButton()
    button.setTitle("Create recipe", for: .normal)
    button.backgroundColor = .red
    button.layer.cornerRadius = 15
    button.titleLabel?.font = .poppinsSemiBold(size: 20)
    button.titleLabel?.textColor = .white
    button.isEnabled = false
    return button
  }()

  private lazy var scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    return scrollView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .white
    nameTextField.delegate = self
    setupNavBar()
    setupScrollView()
    setupViews()
    setupConstraints()
    setupDishImageAction()
    keyboard()
    collectionView.delegate = self
    createButton.addTarget(self, action: #selector(addButtonLogic), for: .touchUpInside)
    nameTextField.addTarget(self, action: #selector(nameTextFieldEmpty), for: .editingChanged)
  }

  override func viewWillAppear(_ animated: Bool) {
    tabBarController?.tabBar.isHidden = true
  }

  private func setupNavBar() {
    navigationBar.titleOfViewLabel.text = "Create recipe"
    navigationBar.titleOfViewLabel.font = .poppinsSemiBold(size: 24)
    navigationBar.view.translatesAutoresizingMaskIntoConstraints = false
    addChild(navigationBar)
    view.addSubview(navigationBar.view)
    navigationBar.didMove(toParent: self)
  }

  private func setupDishImageAction() {
    imagePicker.sourceType = .photoLibrary
    imagePicker.delegate = self
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
    dishImageView.addGestureRecognizer(tapGesture)
  }

  private func setupViews() {
    view.addSubview(scrollView)
    scrollView.addSubview(dishImageView)
    dishImageView.addSubview(imageEdit)
    scrollView.addSubview(nameTextField)
    scrollView.addSubview(servingPicker)
    scrollView.addSubview(cookTimePicker)
    scrollView.addSubview(ingredientsLabel)
    scrollView.addSubview(collectionView)
    scrollView.addSubview(createButton)
  }

  func setupScrollView() {
    var height = view.frame.height
    if height < 720 {
      height = 750
    } else {
      height = view.frame.height - 100
    }
    scrollView.contentSize = CGSize(width: .zero, height: height)
    scrollView.backgroundColor = .white
  }

  private func setupConstraints() {
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    servingPicker.translatesAutoresizingMaskIntoConstraints = false
    cookTimePicker.translatesAutoresizingMaskIntoConstraints = false
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    createButton.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([

      navigationBar.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      navigationBar.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      navigationBar.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      navigationBar.view.heightAnchor.constraint(equalToConstant: 50),

      scrollView.topAnchor.constraint(equalTo: navigationBar.view.bottomAnchor),
      scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.bottomAnchor),

      dishImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 5),
      dishImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      dishImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      dishImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      dishImageView.heightAnchor.constraint(equalToConstant: 200),

      imageEdit.rightAnchor.constraint(equalTo: dishImageView.rightAnchor, constant:  -10),
      imageEdit.topAnchor.constraint(equalTo: dishImageView.topAnchor,constant: 10),

      nameTextField.topAnchor.constraint(equalTo: dishImageView.bottomAnchor, constant: 5),
      nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      nameTextField.heightAnchor.constraint(equalToConstant: 44),

      servingPicker.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 5),
      servingPicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      servingPicker.heightAnchor.constraint(equalToConstant: 44),
      servingPicker.widthAnchor.constraint(equalTo: dishImageView.widthAnchor),

      cookTimePicker.topAnchor.constraint(equalTo: servingPicker.bottomAnchor, constant: 5),
      cookTimePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      cookTimePicker.heightAnchor.constraint(equalToConstant: 44),
      cookTimePicker.widthAnchor.constraint(equalTo: dishImageView.widthAnchor),

      ingredientsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      ingredientsLabel.heightAnchor.constraint(equalToConstant: 40),
      ingredientsLabel.topAnchor.constraint(equalTo: cookTimePicker.bottomAnchor, constant: 5),

      collectionView.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor, constant:  5),
      collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      collectionView.widthAnchor.constraint(equalTo: dishImageView.widthAnchor),
      collectionView.heightAnchor.constraint(equalToConstant: 220),

      createButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
      createButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
      createButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
      createButton.heightAnchor.constraint(equalToConstant: 56)

    ])
  }

  @objc func imageTapped() {
    let imagePicker = UIImagePickerController()
    imagePicker.delegate = self
    imagePicker.sourceType = .photoLibrary
    present(imagePicker, animated: true, completion: nil)
  }

  @objc func addButtonLogic() {
    SaveToCoreData.saveRecipeInfoToCoreData(dishImageView.image!, nameTextField.text!, rowDataPikers.serving, rowDataPikers.cookTime)
    SaveToCoreData.saveArrayOfArraysToCoreData([rowDataArray])
    _ = GetFromCoreData.fetchArrayOfArraysFromCoreData()
    showRecipeAddedAlert()
    rowDataPikers = RowDataPiker() // В в самом конце после сохранения
  }

  func showRecipeAddedAlert() {
    let alertController = UIAlertController(title: "Your recipe has been added.", message: nil, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
      let viewController = MainTabBarController()
      viewController.selectedIndex = 4
      self.navigationController?.setViewControllers([viewController], animated: true)
      self.navigationController?.navigationBar.isHidden = true
    }
    alertController.addAction(okAction)
    present(alertController, animated: true, completion: nil)
  }

  func ifAddButtonAvailable() {
    if let text = nameTextField.text, text.isEmpty {
      return
    }

    for i in 0...rowDataArray.count - 1  {
      if  rowDataArray[i].isField1 && rowDataArray[i].isField2 {
        createButton.isEnabled = true
      } else {
        createButton.isEnabled = false
        break
      }
    }
  }

  private func removeViews() {
    dishImageView.removeFromSuperview()
    nameTextField.removeFromSuperview()
    servingPicker.removeFromSuperview()
    cookTimePicker.removeFromSuperview()
    ingredientsLabel.removeFromSuperview()
    createButton.removeFromSuperview()
  }

  func setupNewConstrains() {
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: navigationBar.view.bottomAnchor, constant: 5),
      collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      collectionView.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor)
    ])
  }

  @objc func nameTextFieldEmpty() {

    if let text = nameTextField.text, text.isEmpty {
      nameTextField.layer.borderColor = UIColor.red.cgColor
      createButton.isEnabled = false
    } else {
      nameTextField.layer.borderColor = UIColor.systemGreen.cgColor
    }
    ifAddButtonAvailable()
  }

  func keyboard() {
    // Подписываемся на уведомления о появлении и скрытии клавиатуры
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
  }

  @objc func keyboardWillShow(_ notification: Notification) {
    if !nameTextField.isFirstResponder {
      UIView.animate(withDuration: 0.3) {
        self.removeViews()
        self.setupNewConstrains()
      }
    }
  }

  @objc func keyboardWillHide(_ notification: Notification) {
    if !nameTextField.isFirstResponder {
      collectionView.removeFromSuperview()

      UIView.animate(withDuration: 0.3) {
        self.setupViews()
        self.setupConstraints()
      }
    }
    ifAddButtonAvailable()
  }
}

//MARK: = Extensions
extension CreateRecipeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let selectedImage = info[.originalImage] as? UIImage {
      dishImageView.image = selectedImage
    }
    picker.dismiss(animated: true, completion: nil)
  }

  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true, completion: nil)
  }
}

extension CreateRecipeViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    nameTextField.resignFirstResponder()
    return true
  }
}

extension CreateRecipeViewController: CreateRecipeViewControllerDelegate {
  func isNewTexFieldAdded() {
    createButton.isEnabled = false
    ifAddButtonAvailable()
  }
}

protocol CreateRecipeViewControllerDelegate {
  func isNewTexFieldAdded()
}
