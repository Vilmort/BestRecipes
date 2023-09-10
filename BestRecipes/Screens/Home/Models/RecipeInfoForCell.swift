//
//  RecipeFullInfoForCell.swift
//  BestRecipes
//
//  Created by Vanopr on 29.08.2023.
//

import Foundation

struct RecipeInfoForCell: Codable, Equatable {
  let id: Int
  let title: String
  let image: String
  let readyInMinutes: Int
  let servings: Int
  let sourceName: String
  let aggregateLikes: Int
}
