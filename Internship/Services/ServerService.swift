//
//  ServerService.swift
//  Internship
//
//  Created by Ildar on 12/31/20.
//

import UIKit

enum NetworkError: Error {
    case badData
    case badBundleUrl
    case badUrl
}


protocol ServerServiceProtcol: class {
    func loadAvitoJSON(completion: @escaping (Result<AvitoData,NetworkError>) -> Void)
}

class ServerService: ServerServiceProtcol {
    func loadAvitoJSON(completion: @escaping (Result<AvitoData,NetworkError>) -> Void) {
        
        let decoder = JSONDecoder()
        
        if let url = Bundle.main.url(forResource: "result", withExtension: "json") {
            if let data = try? Data(contentsOf: url) {
                if let avitoData = try? decoder.decode(AvitoData.self, from: data) {
                    completion(.success(avitoData))
                } else {
                    completion(.failure(.badData))
                }
            } else {
                completion(.failure(.badUrl))
            }
        } else {
            completion(.failure(.badBundleUrl))
        }
    }
}
