//
//  JASON.swift
//  BestRecipes
//
//  Created by Vanopr on 27.08.2023.
//

import Foundation


struct JSONDecoderManager {
    private let decoder = JSONDecoder()
    func decode<T: Decodable>(_ data: Data) throws -> T {
            return try decoder.decode(T.self, from: data)
    }
}
