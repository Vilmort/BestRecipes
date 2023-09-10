//
//  TitleViewController.swift
//  BestRecipes
//
//  Created by Anastasia Rybakova on 08.09.2023.
//

import UIKit

class TitleViewController: UIViewController {

  //MARK: - User Interface
  private lazy var backgroundImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "Onboarding0")
    imageView.contentMode = .scaleAspectFill
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  private lazy var topLabel: UILabel = {
    let topLabel = UILabel.makeLabel(font: .poppinsRegular(size: 16), textColor: .white)
    topLabel.text = "Premium recipes"
    topLabel.numberOfLines = 1
    topLabel.textAlignment = .center
    topLabel.translatesAutoresizingMaskIntoConstraints = false
    return topLabel
  }()

  private lazy var titleLabel: UILabel = {
    let titleLabel = UILabel.makeLabel(font: .poppinsSemiBold(size: 40), textColor: .white)
    titleLabel.text = "Best Recipe"
    titleLabel.font = UIFont.systemFont(ofSize: 48, weight: .bold)
    titleLabel.textAlignment = .center
    titleLabel.numberOfLines = 0
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    return titleLabel
  }()

  private lazy var descriptionLabel: UILabel = {
    let descriptionLabel = UILabel.makeLabel(font: .poppinsRegular(size: 16), textColor: .white)
    descriptionLabel.text = "Find best recipes for cooking"
    descriptionLabel.numberOfLines = 1
    descriptionLabel.textAlignment = .center
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    return descriptionLabel
  }()

  private lazy var getStartedButton: UIButton = {
    let button = UIButton()
    button.setTitle("Get Started", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.backgroundColor = UIColor(red: 0.89, green: 0.24, blue: 0.24, alpha: 1.00)
    button.layer.cornerRadius = 28
    button.addTarget(self, action: #selector(getStartedButtonTapped), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    addSubviews()
    setupConstraints()
  }

  private func addSubviews() {
    view.addSubview(backgroundImageView)
    view.addSubview(topLabel)
    view.addSubview(titleLabel)
    view.addSubview(descriptionLabel)
    view.addSubview(getStartedButton)
  }

  //MARK: - Functions
  @objc private func getStartedButtonTapped() {
    let viewController = OnboardingViewController()
    navigationController?.pushViewController(viewController, animated: false)
  }
}

// MARK: - Extension
extension TitleViewController {

  private func setupConstraints() {
    view.backgroundColor = .white

    NSLayoutConstraint.activate([
      backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
      backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

      topLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      topLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),

      getStartedButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
      getStartedButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
      getStartedButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
      getStartedButton.heightAnchor.constraint(equalToConstant: 56),

      titleLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -30),
      titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      titleLabel.widthAnchor.constraint(equalToConstant: 320),

      descriptionLabel.bottomAnchor.constraint(equalTo: getStartedButton.topAnchor, constant: -64),
      descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
    ])
  }
}
