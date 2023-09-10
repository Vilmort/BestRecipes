//
//  NetworkManager.swift
//  BestRecipes
//
//  Created by Vanopr on 27.08.2023.
//

import Foundation

struct NetworkManager {
   
    let jsonService = JSONDecoderManager()
        
    func request<T: Decodable>(urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw NetworkError.url
        }
        let urlRequest = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        return try jsonService.decode(data)
    }
    
    enum NetworkError: Error {
        case url
    }
   
}
