//
//  MyRecipeCollectionView.swift
//  BestRecipes
//
//  Created by Александра Савчук on 31.08.2023.
//

import UIKit

class MyRecipeCollectionView: UIView {

  var isButtonEnable1 = false
  var isButtonEnable2 = false
  var delegate: CreateRecipeViewControllerDelegate?

  let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    return collectionView
  }()
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupUI()
  }
  
  private func setupUI() {
    backgroundColor = .white
    setupCollectionView()
    generateInitialData()
  }
  
  private func generateInitialData() {
    rowDataArray = [
      RowDataCell(textField1Text: "", textField2Text: "", isSelected: true)
    ]
  }
  
  private func setupCollectionView() {
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(MyRecipeCollectionCell.self, forCellWithReuseIdentifier: "MyRecipeCollectionCell")
    addSubview(collectionView)
    
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
}

extension MyRecipeCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return rowDataArray.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyRecipeCollectionCell", for: indexPath) as! MyRecipeCollectionCell
    
    let rowData = rowDataArray[indexPath.row]
    
    cell.textField1.text = rowData.textField1Text
    cell.textField2.text = rowData.textField2Text
    cell.selectButton.isSelected = rowData.isSelected

    cell.selectButton.tag = indexPath.item
    cell.indexPath = indexPath
    cell.collectionDelegate = self

    if let text = cell.textField1.text, text.isEmpty {
      cell.textField1.layer.borderColor = UIColor.red.cgColor
    } else {
      cell.textField1.layer.borderColor = UIColor.systemGreen.cgColor
    }

    if let text = cell.textField2.text, text.isEmpty {
      cell.textField2.layer.borderColor = UIColor.red.cgColor
    } else {
      cell.textField2.layer.borderColor = UIColor.systemGreen.cgColor
    }
    return cell
  }
}

extension MyRecipeCollectionView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.bounds.width, height: 40)
  }
}

extension MyRecipeCollectionView: MyRecipeCollectionCellDelegate {
  func selectButtonTapped(at indexPath: Int) {

    if indexPath != 0 {
      rowDataArray.remove(at: indexPath)
    } else {
      let blancDataRow = RowDataCell(textField1Text: "", textField2Text: "", isSelected: false, isField1: false, isField2: false)
      rowDataArray.insert(blancDataRow, at: rowDataArray.count)

    }
    delegate?.isNewTexFieldAdded()
    collectionView.reloadData()
  }
  
  func textField1DidChange(at indexPath: IndexPath, newValue: String) {
    if (0...rowDataArray.count).contains(indexPath.row) {
      rowDataArray[indexPath.row].textField1Text = newValue

      if !newValue.isEmpty {
        rowDataArray[indexPath.row].isField1 = true
      } else {
        rowDataArray[indexPath.row].isField1 = false
      }
    }
  }
  
  func textField2DidChange(at indexPath: IndexPath, newValue: String) {
    if (0...rowDataArray.count).contains(indexPath.row) {
      rowDataArray[indexPath.row].textField2Text = newValue

      if !newValue.isEmpty {
        rowDataArray[indexPath.row].isField2 = true
      } else {
        rowDataArray[indexPath.row].isField2 = false
      }
    }
  }
}

var rowDataArray: [RowDataCell] = []

protocol MyRecipeCollectionCellDelegate: AnyObject {
  func selectButtonTapped(at indexPath: Int)
  func textField1DidChange(at indexPath: IndexPath, newValue: String)
  func textField2DidChange(at indexPath: IndexPath, newValue: String)
}
