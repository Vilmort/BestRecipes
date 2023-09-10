//
//  OnboardingViewController.swift
//  BestRecipes
//
//  Created by Александра Савчук on 26.08.2023.
//

import UIKit

class OnboardingViewController: UIViewController {

  var onCompletion: (() -> Void)?

  private let slides: [Slide] = [
    Slide(image: UIImage(named: "Onboarding1"), title: "Recipes from all over the World", description: ""),
    Slide(image: UIImage(named: "Onboarding2"), title: "Recipes with each and every detail", description: ""),
    Slide(image: UIImage(named: "Onboarding3"), title: "Cook it now or save it for later", description: "")
  ]

  //MARK: - Outlets
  private lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  private lazy var titleLabel: UILabel = {
    let titleLabel = UILabel.makeLabel(font: .poppinsSemiBold(size: 40), textColor: .white)
    titleLabel.font = UIFont.systemFont(ofSize: 48, weight: .bold)
    titleLabel.textAlignment = .center
    titleLabel.numberOfLines = 0
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    return titleLabel
  }()

  private lazy var descriptionLabel: UILabel = {
    let descriptionLabel = UILabel.makeLabel(font: .poppinsRegular(size: 16), textColor: .white)
    descriptionLabel.numberOfLines = 1
    descriptionLabel.textAlignment = .center
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    return descriptionLabel
  }()

  private lazy var nextButton: UIButton = {
    let nextButton = UIButton()
    nextButton.setTitleColor(.white, for: .normal)
    nextButton.backgroundColor = UIColor(red: 0.89, green: 0.24, blue: 0.24, alpha: 1.00)
    nextButton.layer.cornerRadius = 28
    nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    nextButton.translatesAutoresizingMaskIntoConstraints = false
    return nextButton
  }()

  private lazy var skipButton: UIButton = {
    let skipButton = UIButton()
    skipButton.setTitleColor(.white, for: .normal)
    skipButton.setTitle("Skip", for: .normal)
    skipButton.titleLabel?.font = UIFont.systemFont(ofSize: 10)
    skipButton.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
    skipButton.translatesAutoresizingMaskIntoConstraints = false
    return skipButton
  }()

  private var currentIndex = 0 {
    didSet {
      updateUI()
    }
  }

  private let pageControl: UIPageControl = {
    let page = UIPageControl()
    page.numberOfPages = 3
    page.currentPage = 0
    page.backgroundStyle = .minimal
    page.pageIndicatorTintColor = .lightGray
    page.currentPageIndicatorTintColor = UIColor.primary30
    page.setIndicatorImage(UIImage(named: "Rectangle0"), forPage: 0)
    page.setIndicatorImage(UIImage(named: "Rectangle1"), forPage: 1)
    page.setIndicatorImage(UIImage(named: "Rectangle1"), forPage: 2)

    page.translatesAutoresizingMaskIntoConstraints = false
    page.isUserInteractionEnabled = true
    return page
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    addSubviews()
    setupConstraints()
    currentIndex = 0
    pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)
  }

  private func addSubviews() {
    view.addSubview(imageView)
    view.addSubview(pageControl)
    view.addSubview(titleLabel)
    view.addSubview(descriptionLabel)
    view.addSubview(nextButton)
    view.addSubview(skipButton)
  }


  //MARK: - Functions
  @objc private func updateUI() {
    let slide = slides[currentIndex]

    imageView.image = slide.image
    titleLabel.text = slide.title
    descriptionLabel.text = slide.description

    if currentIndex == slides.count - 1 {
      nextButton.setTitle("Start cooking", for: .normal)
      titleLabel.font = titleLabel.font.withSize(40)
      skipButton.isHidden = true
    } else {
      nextButton.setTitle("Continue", for: .normal)
      titleLabel.font = titleLabel.font.withSize(40)
      skipButton.isHidden = false
    }
  }

  @objc private func nextButtonTapped() {
    if currentIndex == slides.count - 1 {
      print("Last button pressed")
      goToHomeScreen()
    } else {
      print("Not last button pressed")
      currentIndex += 1
      updateUI()
      pageControl.currentPage = currentIndex
      pageControl.setIndicatorImage(UIImage(named: "Rectangle1"), forPage: currentIndex)
    }
  }

  @objc private func skipButtonTapped() {
    print("Skip Button Tapped")
    goToHomeScreen()
  }

  @objc private func pageControlTapped(_ sender: UIPageControl) {
    currentIndex = sender.currentPage
  }

  private func goToHomeScreen() {
    UserDefaults.standard.set(true, forKey: "isOnboardingCompleted")
    let viewController = MainTabBarController()
    navigationController?.setViewControllers([viewController], animated: true)
    navigationController?.navigationBar.isHidden = true
  }
}

// MARK: - Extension
extension OnboardingViewController: UIScrollViewDelegate {
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let width = scrollView.frame.width
    let currentPage = Int((scrollView.contentOffset.x + width / 2) / width)
    if currentPage != currentIndex {
      currentIndex = currentPage
      updateUI()
      pageControl.currentPage = currentIndex
    }
  }
}

extension OnboardingViewController {

  //MARK: - Constraints
  private func setupConstraints() {
    view.backgroundColor = .white

    NSLayoutConstraint.activate([

      imageView.topAnchor.constraint(equalTo: view.topAnchor),
      imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

      nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
      nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
      nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
      nextButton.heightAnchor.constraint(equalToConstant: 56),

      pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      pageControl.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -20),

      titleLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -30),
      titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      titleLabel.widthAnchor.constraint(equalToConstant: 320),

      descriptionLabel.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -64),
      descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

      skipButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      skipButton.topAnchor.constraint(equalTo: nextButton.bottomAnchor, constant: 5)
    ])
  }
}
