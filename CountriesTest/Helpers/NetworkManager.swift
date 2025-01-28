//
//  NetworkManager.swift
//  CountriesTest
//
//  Created by Роман on 28.01.2025.
//

import Foundation

final class NetworkManager {
    private init() {}
    static var shared = NetworkManager()
    
    func fetchAllCountries<T: Codable>() async throws -> T? {
        
        guard let apiEndpoint = Bundle.main.object(forInfoDictionaryKey:"API_BASE_URL") as? String else {
            throw NetworkManagerError.missingKey
        }
        
        guard let endpointURL = URL(string: apiEndpoint) else {
            throw NetworkManagerError.badURL
        }
        
        let (data, res) = try await URLSession.shared.data(from: endpointURL)
        
        guard let response = res as? HTTPURLResponse else {
            throw NetworkManagerError.badData
        }
        
        guard (200...299).contains(response.statusCode) else {
            throw NetworkManagerError.badResponse
        }
        
        do {
            guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
                throw NetworkManagerError.dataCantBeDecoded
            }
            
            return decodedData
            
        } catch {
            throw NetworkManagerError.dataCantBeDecoded
        }
    }
}

enum NetworkManagerError: Error {
    case missingKey, badURL, badData, badResponse, dataCantBeDecoded
}
