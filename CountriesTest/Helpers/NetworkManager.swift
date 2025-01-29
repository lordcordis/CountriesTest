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
            throw NetworkError.badData
        }
        
        guard (200...299).contains(response.statusCode) else {
            throw NetworkError.badResponse
        }
        
        do {
            guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
                let string = String.init(data: data, encoding: .utf8)
                print(string)
                throw NetworkError.dataCantBeDecoded
            }
            
            return decodedData
            
        } catch {
            print(error.localizedDescription)
            throw NetworkError.dataCantBeDecoded
        }
    }
}

