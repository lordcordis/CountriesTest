//
//  NetworkManager.swift
//  CountriesTest
//
//  Created by Роман on 28.01.2025.
//

import Foundation

final class NetworkManager {
    
    weak var delegate: URLSessionTaskDelegate?
    
    init() {
        
    }
    
    func fetchData<T: Codable>(url: URL) async throws -> T? {
        
        print(url.absoluteString)
        
        let urlSession = URLSession(configuration: .default, delegate: delegate, delegateQueue: nil)
        
        let (data, res) = try await urlSession.data(from: url)
        
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
    case missingKey, badURL, badData, badResponse, dataCantBeDecoded, listIsEmpty
}
