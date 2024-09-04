//
//  ProductServices.swift
//  TestTask(SKU)
//
//  Created by Александр Новиков on 31.08.2024.
//

import Foundation

protocol ProductServiceProtocol {
    func requestProducts(completion: @escaping (Result<[ProductModel], Error>) -> ())
}

final class ProductService: ProductServiceProtocol {
    
    private let dataLoader: LoadData
    private let converter: Converter
    private let productCreator: ProductCreator

    init(dataLoader: LoadData = LoadData(), converter: Converter = Converter(), productCreator: ProductCreator = ProductCreator()) {
        self.dataLoader = dataLoader
        self.converter = converter
        self.productCreator = productCreator
    }

    
    func requestProducts(completion: @escaping (Result<[ProductModel], Error>) -> ()) {
        dataLoader.loadTransactions { transactionsResult in
            switch transactionsResult {
            case .success(let transactions):
                self.converter.setupConversionRates { ratesResult in
                    switch ratesResult {
                        case .success:
                        let products = self.productCreator.createProducts(from: transactions, converter: self.converter)
                        completion(.success(products))
                        case .failure(let error):
                        completion(.failure(error))
                    }
                    
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
