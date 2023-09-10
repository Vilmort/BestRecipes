//
//  RecipeModel .swift
//  BestRecipes
//
//  Created by Vanopr on 28.08.2023.
//

import Foundation

// Модель для Trending, SeeAll и Search и Categories

struct RecipeResults: Codable {
  let results: [Recipe]
}

struct Recipe: Codable, Equatable {
  let id: Int
  let title: String
  let image: String
}
