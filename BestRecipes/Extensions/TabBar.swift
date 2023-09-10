//
//  TabBar.swift
//  BestRecipes
//
//  Created by Александра Савчук on 27.08.2023.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {

  private let notification = UIViewController()

  override func viewDidLoad() {
    super.viewDidLoad()
    self.delegate = self
    tabBar.barTintColor = .white
    tabBar.barStyle = .black
    setupTabBar()
    setupItems()
  }

  private func setupTabBar() {
    if let backgroundImage = UIImage(named: "background") {
      let backgroundImageView = UIImageView(image: backgroundImage)
      backgroundImageView.contentMode = .scaleAspectFill
      tabBar.addSubview(backgroundImageView)
      backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        backgroundImageView.topAnchor.constraint(equalTo: tabBar.topAnchor),
        backgroundImageView.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor),
        backgroundImageView.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor),
        backgroundImageView.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor)
      ])
    } else {
      print("Background image 'background' not found.")
    }
  }

  private func setupItems() {
    let customButtonController = CreateRecipeViewController()
    customButtonController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "add")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "add")?.withRenderingMode(.alwaysOriginal))
    customButtonController.tabBarItem.imageInsets = UIEdgeInsets(top: -20, left: 0, bottom: 20, right: 0)

    let homepage = HomeViewController()
    homepage.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "main")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "mainSelect")?.withRenderingMode(.alwaysOriginal))

    let discover = DiscoverViewController()
    discover.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "bookmark")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "bookmarkSelect")?.withRenderingMode(.alwaysOriginal))

    let notification = ShopingListViewController()
    notification.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "notification")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "notificationSelect")?.withRenderingMode(.alwaysOriginal))

    let profile = ProfilePageViewController()
    profile.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "profile")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "profileSelect")?.withRenderingMode(.alwaysOriginal))

    setViewControllers([homepage, discover, customButtonController, notification, profile], animated: true)
  }
}
