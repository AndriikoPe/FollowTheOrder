//
//  FortuneProvider.swift
//  FollowTheOrder
//
//  Created by Пермяков Андрей on 31.05.2022.
//

import Foundation

class FortuneProvider {
    private static let url = URL(string: "http://yerkee.com/api/fortune")
    
    private init() {}
    
    static func requestFortune(_ completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = url else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                if let error = error { completion(.failure(error)) }
                return
            }
            do {
                let decodedData = try JSONDecoder().decode(Fortune.self, from: data)
                completion(.success(decodedData.fortune))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

struct Fortune: Codable {
    let fortune: String
}
