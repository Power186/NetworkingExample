//
//  NetworkController.swift
//  FetchRewards
//
//  Created by Scott on 2/3/21.
//

import Foundation

final class NetworkController {
    
    enum jsonError: Error {
        case dataMissing
    }
    
    func fetchItems(completion: @escaping (Result<[Item], Error>) -> Void) {
        let url = URL(string: "https://fetch-hiring.s3.amazonaws.com/hiring.json")
        guard let safeUrl = url else { return }
        
        let task = URLSession.shared.dataTask(with: safeUrl) { (data, _, error) in
            if let data = data {
                let jsonDecoder = JSONDecoder()
                do {
                    let itemInfo = try jsonDecoder.decode([Item].self, from: data)
                    completion(.success(itemInfo))
                } catch {
                    completion(.failure(jsonError.dataMissing))
                }
            } else {
                if let error = error {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}
