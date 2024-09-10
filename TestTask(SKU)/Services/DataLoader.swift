//
//  ReceiveData.swift
//  TestTask(SKU)
//
//  Created by Александр Новиков on 03.09.2024.
//

import Foundation

protocol DataLoaderProtocol {
    func  load<T: Decodable>(resource: String, type: T.Type, completion: @escaping (Result<T, Error>) -> Void)
}

final class DataLoader: DataLoaderProtocol {

    func load<T: Decodable>(resource: String, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = Bundle.main.url(forResource: resource, withExtension: "plist") else {
            completion(.failure(NSError(domain: "Invalid resource", code: 0, userInfo: nil)))
            return
        }
        do {
            let data = try Data(contentsOf: url)
            let result = try PropertyListDecoder().decode(T.self, from: data)
            completion(.success(result))
        } catch {
            completion(.failure(error))
        }
    }
}
