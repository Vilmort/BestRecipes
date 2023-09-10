//
//  NavBar.swift
//  BestRecipes
//
//  Created by Vanopr on 28.08.2023.
//

import UIKit
import Foundation

class CustomNavigationBar: UIViewController {

  let navigationBar = UINavigationBar()
  var textToShare = ""

  var titleOfViewLabel: UILabel = {
    var label = UILabel()
    label.text = "Screen Name "
    label.textColor = .black
    label.textAlignment = .center
    label.font = .poppinsSemiBold(size: 24)
    return label
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavigationBar()
  }

  private func setupNavigationBar() {
    navigationBar.translatesAutoresizingMaskIntoConstraints = false
    titleOfViewLabel.translatesAutoresizingMaskIntoConstraints = false

    navigationBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
    navigationBar.shadowImage = UIImage()

    navigationBar.backgroundColor = .white
    navigationBar.barTintColor = .white
    navigationBar.tintColor = .black

    let backButtonImage = UIImage(systemName: "arrow.backward")
    let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(backButtonAction))
    backButton.tintColor = .black

    let shareButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .plain, target: self, action: #selector(shareButtonAction))
    shareButton.tintColor = .black

    let navItem = UINavigationItem()
    navItem.leftBarButtonItem = backButton
    navItem.rightBarButtonItem = shareButton

    navigationBar.items = [navItem]
    navigationBar.backgroundColor = .clear
    navigationBar.addSubview(titleOfViewLabel)
    view.addSubview(navigationBar)

    NSLayoutConstraint.activate([
      navigationBar.topAnchor.constraint(equalTo: view.topAnchor),
      navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      navigationBar.heightAnchor.constraint(equalToConstant: 50),
      titleOfViewLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
      titleOfViewLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])
  }

  @objc  func backButtonAction() {
    if navigationController?.viewControllers.count ?? 0 > 1 {
      navigationController?.popViewController(animated: true)
    } else {
      self.tabBarController?.selectedIndex = 0
      dismiss(animated: true)
    }
  }

  func ifAddViewOpen() {
    if let currentViewController = self.navigationController?.visibleViewController {
      if currentViewController is CreateRecipeViewController {
      }
    }
  }

  @objc  func shareButtonAction() {
    textToShare += ""
    let itemsToShare: [Any] = [textToShare]
    let activityViewController = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)
    activityViewController.view.tintColor = UIColor.black
    present(activityViewController, animated: true, completion: nil)
  }
}
