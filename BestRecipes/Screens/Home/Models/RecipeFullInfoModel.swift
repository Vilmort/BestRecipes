//
//  File1.swift
//  BestRecipes
//
//  Created by Vanopr on 28.08.2023.
//

import Foundation

// Модель для Detail

struct RecipeFullInfo: Codable {
    let id: Int
    let image: String
    let title: String
    let readyInMinutes: Int
    let servings: Int
    let spoonacularSourceUrl: String
    let instructions: String
    let extendedIngredients: [ExtendedIngredient]
    let aggregateLikes: Int
}

struct ExtendedIngredient: Codable {
    let id: Int
    let name: String
    let amount: Double
    let unit: String
    let measures: Measures
    let image: String
}

struct Measures: Codable {
    let us, metric: Metric
}

struct Metric: Codable {
    let amount: Double
    let unitShort, unitLong: String
}
