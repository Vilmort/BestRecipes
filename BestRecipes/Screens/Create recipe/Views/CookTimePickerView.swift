//
//  CookTimePickerView.swift
//  BestRecipes
//
//  Created by Александра Савчук on 29.08.2023.
//

import UIKit

class CookTimePickerView: UIView {
  
  let pickerData = Array(stride(from: 5, through: 120, by: 5))
  
  private let imageView: UIImageView = {
    let imageView = UIImageView(image: UIImage(systemName: "clock"))
    imageView.backgroundColor = .white
    imageView.layer.cornerRadius = 10
    imageView.tintColor = .black
    imageView.contentMode = .center
    return imageView
  }()
  
  private let label = UILabel.makeLabel(text: "Cook time", font: .poppinsSemiBold(size: 16), textColor: .black)
  private let labelServes = UILabel.makeLabel(text: "20 Min", font: .poppinsRegular(size: 16), textColor: .neutral50)
  
  private lazy var picker: UIPickerView = {
    let picker = UIPickerView()
    picker.dataSource = self
    picker.delegate = self
    picker.isHidden = true
    return picker
  }()
  
  private let arrowImageView: UIImageView = {
    let image = UIImageView()
    image.image = UIImage(systemName: "arrow.right")
    image.tintColor = .black
    image.isUserInteractionEnabled = true
    return image
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupViews() {
    backgroundColor = .neutral10
    layer.cornerRadius = 8
    addSubview(imageView)
    addSubview(label)
    addSubview(arrowImageView)
    addSubview(picker)
    addSubview(labelServes)
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(arrowLabelTapped))
    arrowImageView.addGestureRecognizer(tapGesture)
  }
  
  private func setupConstraints() {
    imageView.translatesAutoresizingMaskIntoConstraints = false
    label.translatesAutoresizingMaskIntoConstraints = false
    picker.translatesAutoresizingMaskIntoConstraints = false
    arrowImageView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
      imageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
      imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
      imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
      
      label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
      label.centerYAnchor.constraint(equalTo: centerYAnchor),
      
      arrowImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
      arrowImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
      
      labelServes.trailingAnchor.constraint(equalTo: arrowImageView.leadingAnchor, constant: -10),
      labelServes.centerYAnchor.constraint(equalTo: centerYAnchor),
      labelServes.widthAnchor.constraint(equalToConstant: 50),
      
      picker.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
      picker.centerYAnchor.constraint(equalTo: centerYAnchor),
      picker.widthAnchor.constraint(equalTo: widthAnchor, constant: -50)
    ])
  }
  
  func updateLabelServes(with value: String) {
    labelServes.text = value
  }
  
  @objc private func arrowLabelTapped() {
    if picker.isHidden {
      picker.isHidden = false
    } else {
      picker.isHidden = true
    }
  }
}

extension CookTimePickerView: UIPickerViewDataSource, UIPickerViewDelegate {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return pickerData.count
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    let value = pickerData[row]
      return "\(value) min"
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    let selectedValue = pickerData[row]
    let selectedValueString = String(selectedValue) + " min"
      rowDataPikers.cookTime = selectedValueString

    updateLabelServes(with: selectedValueString)
    picker.isHidden = true
  }
}
