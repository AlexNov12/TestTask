//
//  ProductServices.swift
//  TestTask(SKU)
//
//  Created by Александр Новиков on 31.08.2024.
//

import Foundation

protocol ProductServiceProtocol {
    func requestProducts(completion: @escaping (Result<[ProductModel], Error>) -> Void)
}

final class ProductService: ProductServiceProtocol {
    private let dataLoader = DataLoader()
    private let productCreator = ProductCreator()
    

    func requestProducts(completion: @escaping (Result<[ProductModel], Error>) -> Void) {
        dataLoader.load(
            resource: "transactions",
            type: [TransactionResponse].self
        ) { transactionsResult in
            switch transactionsResult {
            case .success(let transactions):
                let products = self.productCreator.createProducts(from: transactions)
                completion(.success(products))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
