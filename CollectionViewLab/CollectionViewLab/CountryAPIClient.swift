//
//  CountryAPIClient.swift
//  CollectionViewLab
//
//  Created by Maitree Bain on 1/15/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import Foundation
import NetworkHelper


struct CountryAPIClient {
    
    static func getCountry(for name: String, completion: @escaping (Result<[CountryData], AppError>) -> ()){
        let endpointURL = "https://restcountries.eu/rest/v2/name/\(name)"
        
        guard let url = URL(string: endpointURL) else {
            completion(.failure(.badURL(endpointURL)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
          switch result {
          case .failure(let appError):
            completion(.failure(.networkClientError(appError)))
          case .success(let data):
            do {
              let results = try JSONDecoder().decode([CountryData].self, from: data)
                completion(.success(results))
            } catch {
              completion(.failure(.decodingError(error)))
            }
          }
        }
    }
    
}
