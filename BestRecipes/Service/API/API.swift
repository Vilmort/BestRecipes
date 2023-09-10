//
//  API.swift
//  BestRecipes
//
//  Created by Vanopr on 27.08.2023.
//

import Foundation
import UIKit

let networkManager = NetworkManager()
enum url {
  static let MainUrl = "https://api.spoonacular.com/recipes/"
}

let apiKey = [
"7bacf3f7cc7e408e9949dd374a8ddad7",
"8cf18949852e4f6e82c12342cf83cdc9",
"11e930669851467ebda17458e91269a9",
"a1a20a4a124747d68fb8dd4f0a957e45",
"977e7847d283492bb87bffe3d7256e12",
"dbe02e6c827948cab1164a95cab41203",
"4746f1a7e1ad4876996cd8e626b05ce4",
"b6dbf7fcf5094745ac11204866483713",
"f53c3c540feb41b08450248060e8cd77",
"3df4748a170f45ce9c519d7371a16480"
]

var apiKeySelect = apiKey[0]

enum adds {
  static let popularity = "&sort=popularity"
  static let information = "informationBulk"
  static let number = "&number=50"
  static let complexSearch = "complexSearch"
  static let autocomplete = "autocomplete"
  static let instructions = "analyzedInstructions"

}

struct RecipeAPI {

  //MARK: - Загрузка изображений

  static func loadImageFromURL(urlString: String, completion: @escaping (UIImage?) -> Void) {
    guard let url = URL(string: urlString) else {
      completion(nil)
      return
    }
    URLSession.shared.dataTask(with: url) { data, response, error in
      guard let data = data, error == nil else {
        completion(nil)
        return
      }
      let image = UIImage(data: data)
      completion(image)
    }.resume()
  }


  //MARK: - Запросы данных

  // Для Trending
  static func fetchTrends() async throws -> RecipeResults {
    let urlString = "\(url.MainUrl)\(adds.complexSearch)?apiKey=\(apiKeySelect)\(adds.popularity)"
    return try await networkManager.request(urlString: urlString)
  }
  // Для See all
  static func fetchTrendsAll() async throws -> RecipeResults {
    let urlString = "\(url.MainUrl)\(adds.complexSearch)?apiKey=\(apiKeySelect)\(adds.popularity)\(adds.number)"
    return try await networkManager.request(urlString: urlString)
  }
  // Для Detail
  static func fetchFullInfo(_ id: Int) async throws ->  [RecipeFullInfo] {
    let urlString = "\(url.MainUrl)\(adds.information)?ids=\(id)&apiKey=\(apiKeySelect)"
    return try await networkManager.request(urlString: urlString)
  }
  // Для Search и Categories(просто вместо request подставить нужную нам категорию)
  static func fetchSearch(with request: String) async throws -> RecipeResults {
    let requestForURL = request.replacingOccurrences(of: " ", with: "%20")
    let urlString = "\(url.MainUrl)\(adds.complexSearch)?query=\(requestForURL)&number=10&apiKey=\(apiKeySelect)"
    return try await networkManager.request(urlString: urlString)
  }
  // Получение данных для нескольких ids: String
  static func fetchFullInfoFromIdString(with ids: String) async throws -> [RecipeInfoForCell] {
    let urlString = "\(url.MainUrl)\(adds.information)?ids=\(ids)&apiKey=\(apiKeySelect)"
    return try await networkManager.request(urlString: urlString)
  }

  static func fetchCuisine(with request: String) async throws -> RecipeResults {
    let urlString = "\(url.MainUrl)\(adds.complexSearch)?cuisine=\(request)&number=10&apiKey=\(apiKeySelect)"
    return try await networkManager.request(urlString: urlString)
  }

  static func fetchInstructions(with ids: String) async throws -> RecipeResults {
    let urlString = "\(url.MainUrl)\(ids)\(adds.instructions)apiKey=\(apiKeySelect)"
    return try await networkManager.request(urlString: urlString)
  }
}
