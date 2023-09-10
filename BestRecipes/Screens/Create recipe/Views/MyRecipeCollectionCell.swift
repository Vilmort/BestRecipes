//
//  MyRecipeCollectionCell.swift
//  BestRecipes
//
//  Created by Александра Савчук on 31.08.2023.
//

import UIKit

class MyRecipeCollectionCell: UICollectionViewCell, UITextFieldDelegate {
  
  var collectionDelegate: MyRecipeCollectionCellDelegate?
  var indexPath: IndexPath?
  
  let textField1: UITextField = {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.layer.borderWidth = 1.0
    textField.layer.cornerRadius = 8
    textField.layer.borderColor = UIColor.red.cgColor
    textField.returnKeyType = .done
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
    textField.leftView = paddingView
    textField.leftViewMode = .always
    textField.attributedPlaceholder = NSAttributedString(string: "Item name", attributes:  [.foregroundColor: UIColor.gray])
    textField.textColor = .black
    return textField
  }()
  
  let textField2: UITextField = {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.layer.borderWidth = 1.0
    textField.layer.cornerRadius = 8
    textField.layer.borderColor = UIColor.red.cgColor
    textField.returnKeyType = .done
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
    textField.leftView = paddingView
    textField.leftViewMode = .always
    textField.attributedPlaceholder = NSAttributedString(string: "Quantity", attributes:  [.foregroundColor: UIColor.gray])
    textField.textColor = .black
    
    return textField
  }()
  
  let selectButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(systemName: "plus"), for: .selected)
    button.setImage(UIImage(systemName: "minus"), for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
    
    textField1.addTarget(self, action: #selector(textField1DidChange(_:)), for: .allEvents)
    textField2.addTarget(self, action: #selector(textField2DidChange(_:)), for: .editingChanged)
    selectButton.addTarget(self, action: #selector(selectButtonTapped(_:)), for: .touchUpInside)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupUI() {
    addSubview(textField1)
    addSubview(textField2)
    addSubview(selectButton)
    isTexField1Empty()
    isTexField2Empty()
    
    textField1.delegate = self
    textField2.delegate = self
    
    NSLayoutConstraint.activate([
      textField1.topAnchor.constraint(equalTo: topAnchor),
      textField1.leadingAnchor.constraint(equalTo: leadingAnchor),
      textField1.trailingAnchor.constraint(equalTo: textField2.leadingAnchor, constant: -20),
      textField1.bottomAnchor.constraint(equalTo: bottomAnchor),
      selectButton.topAnchor.constraint(equalTo: topAnchor),
      selectButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
      selectButton.heightAnchor.constraint(equalToConstant: 24),
      selectButton.widthAnchor.constraint(equalToConstant: 24),
      selectButton.bottomAnchor.constraint(equalTo: bottomAnchor),
      textField2.topAnchor.constraint(equalTo: topAnchor),
      textField2.widthAnchor.constraint(equalToConstant: 100),
      textField2.bottomAnchor.constraint(equalTo: bottomAnchor),
      textField2.trailingAnchor.constraint(equalTo: selectButton.leadingAnchor)
    ])
    
  }
  
  @objc private func selectButtonTapped(_ sender: UIButton) {
    collectionDelegate?.selectButtonTapped(at: sender.tag)
  }
  
  @objc private func textField1DidChange(_ textField: UITextField) {
    collectionDelegate?.textField1DidChange(at: indexPath!, newValue: textField.text ?? "")
    isTexField1Empty()
  }
  
  @objc private func textField2DidChange(_ textField: UITextField) {
    collectionDelegate?.textField2DidChange(at: indexPath!, newValue: textField.text ?? "")
    isTexField2Empty()
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField1.resignFirstResponder()
    textField2.resignFirstResponder() // Закрываем клавиатуру
    return true
  }
  
  func isTexField1Empty() {
    if let text = textField1.text, text.isEmpty {
      textField1.layer.borderColor = UIColor.red.cgColor
    } else {
      textField1.layer.borderColor = UIColor.systemGreen.cgColor
    }
  }
  
  func isTexField2Empty() {
    if let text = textField2.text, text.isEmpty {
      textField2.layer.borderColor = UIColor.red.cgColor
    } else {
      textField2.layer.borderColor = UIColor.systemGreen.cgColor
    }
  }
}
