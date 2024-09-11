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
    private let dataLoader: DataLoaderProtocol
    private let productCreator: ProductCreatorProtocol
    
    init(dataLoader: DataLoaderProtocol, productCreator: ProductCreatorProtocol) {
        self.dataLoader = dataLoader
        self.productCreator = productCreator
    }

    func requestProducts(completion: @escaping (Result<[ProductModel], Error>) -> Void) {
        let transactionsResult = dataLoader.load(resource: "transactions", type: [TransactionResponse].self)
            switch transactionsResult {
            case .success(let transactions):
                let products = self.productCreator.createProducts(from: transactions)
                completion(.success(products))
            case .failure(let error):
                completion(.failure(error))
            }
    }
}
