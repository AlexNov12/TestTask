//
//  ReceiveData.swift
//  TestTask(SKU)
//
//  Created by Александр Новиков on 03.09.2024.
//

import Foundation

protocol DataLoaderProtocol {
    func  load<T: Decodable>(resource: String, type: T.Type) -> Result<T, Error>
}

final class DataLoader: DataLoaderProtocol {

    func load<T: Decodable>(resource: String, type: T.Type) -> Result<T, Error> {
        guard let url = Bundle.main.url(forResource: resource, withExtension: "plist") else {
            return .failure(NSError(domain: "Invalid resource", code: 0, userInfo: nil))
        }
        do {
            let data = try Data(contentsOf: url)
            let result = try PropertyListDecoder().decode(T.self, from: data)
            return .success(result)
        } catch {
            return .failure(error)
        }
    }
}
