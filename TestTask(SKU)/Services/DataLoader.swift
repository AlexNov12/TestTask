//
//  ReceiveData.swift
//  TestTask(SKU)
//
//  Created by Александр Новиков on 03.09.2024.
//

import Foundation

protocol DataLoaderProtocol {
    func  receiveData<T: Decodable>(resource: String, type: T.Type, completion: @escaping (Result<T, Error>) -> Void)
}

final class DataLoader: DataLoaderProtocol {

    func receiveData<T: Decodable>(resource: String, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
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
    
    func loadRates(completion: @escaping (Result<[RateResponse], Error>) -> Void) {
        receiveData(resource: "rates", type: [RateResponse].self, completion: completion)
    }
    
    func loadTransactions(completion: @escaping (Result<[TransactionResponse], Error>) -> Void) {
        receiveData(resource: "transactions", type: [TransactionResponse].self, completion: completion)
    }
}
