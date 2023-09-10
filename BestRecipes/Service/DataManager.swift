//
//  DataManager.swift
//  BestRecipes
//
//  Created by Александра Савчук on 27.08.2023.
//

import Foundation

final class BookmarksManager {

  static let shared = BookmarksManager()
  private init() {}

  private let defaults = UserDefaults.standard
  private let bookmarksKey = "bookmarks"

  var bookmarksArray: [RecipeInfoForCell] {
    get {
      guard let data = defaults.data(forKey: bookmarksKey) else {
        return []
      }
      do {
        let savedBookmarks = try JSONDecoder().decode([RecipeInfoForCell].self, from: data)
        return savedBookmarks
      } catch {
        print("Error decoding bookmarks: \(error)")
        return []
      }
    }
    set {
      do {
        let savedBookmarks = try JSONEncoder().encode(newValue)
        defaults.set(savedBookmarks, forKey: bookmarksKey)
      } catch {
        print("Error encoding bookmarks: \(error)")
      }
    }
  }

  //MARK: - Functions
  func getBookmarks() -> [RecipeInfoForCell] {
    return bookmarksArray
  }

  func saveBookmarks(_ dataToSave: [RecipeInfoForCell]) {
    do {
      let savedNews = try JSONEncoder().encode(dataToSave)
      defaults.set(savedNews, forKey: "bookmarks")
      defaults.synchronize()
    } catch {
      print("Error encoding results: \(error)")
    }
  }

  private let viewedRecipesKey = "viewedRecipes"

  var viewedRecipesArray: [RecipeInfoForCell] {
    get {
      guard let data = defaults.data(forKey: viewedRecipesKey) else {
        return []
      }
      do {
        let viewedRecipes = try JSONDecoder().decode([RecipeInfoForCell].self, from: data)
        return viewedRecipes
      } catch {
        print("Error decoding viewed recipes: \(error)")
        return []
      }
    }
    set {
      do {
        let viewedRecipes = try JSONEncoder().encode(newValue)
        defaults.set(viewedRecipes, forKey: viewedRecipesKey)
      } catch {
        print("Error encoding viewed recipes: \(error)")
      }
    }
  }
  func getViewedRecipes() -> [RecipeInfoForCell] {
    return viewedRecipesArray
  }

  func saveViewedRecipes(_ dataToSave: [RecipeInfoForCell]) {
    viewedRecipesArray = dataToSave
  }
}

final class SelectedIngredientsManager {
  static let shared = SelectedIngredientsManager()
  var selectedIngredients: [IngredientModel] = []
  private init() {}
}
