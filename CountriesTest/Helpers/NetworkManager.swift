//
//  NetworkManager.swift
//  CountriesTest
//
//  Created by Роман on 28.01.2025.
//

import Foundation

final class NetworkManager {
    
    weak var delegate: URLSessionTaskDelegate?
    
    func fetchData<T: Codable>(url: URL) async throws -> T? {
        
        print(url.absoluteString)
        
        let urlSession = URLSession(configuration: .default)
        
        let (data, res) = try await urlSession.data(from: url)
        
        guard let response = res as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        guard (200...299).contains(response.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        
        return decodedData
    }
}

