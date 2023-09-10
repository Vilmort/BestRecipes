//
//  IngredientModel.swift
//  BestRecipes
//
//  Created by Анастасия Рыбакова on 03.09.2023.
//

import Foundation

struct IngredientModel: Codable, Equatable {
    let image: String
    let name: String
    let amount: Double
    
    static func makeMockData() -> [Self] {
        []
    }
}
