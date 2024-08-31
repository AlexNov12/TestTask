//
//  ProductServices.swift
//  TestTask(SKU)
//
//  Created by Александр Новиков on 31.08.2024.
//

import Foundation


protocol ProductServiceProtocol {
    func requestProducts(completion: @escaping (Result<[ProductsModel], Error>) -> ())
}

final class ProductService: ProductServiceProtocol {
    
    func requestProducts(completion: @escaping (Result<[ProductsModel], Error>) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(.success(Constants.products))
        }
    }
}

private extension ProductService {
    
    enum Constants {
        static let products : [ProductsModel] = [
            .init(sku: "V5239", countOfTransactions: 436, generalMountOfGBP: 10154.463220183503),
            .init(sku: "A8964", countOfTransactions: 420, generalMountOfGBP: 9665.111155963301),
            .init(sku: "W9806", countOfTransactions: 439, generalMountOfGBP: 10082.03472477064),
            .init(sku: "X1893", countOfTransactions: 427, generalMountOfGBP: 9610.049183486251),
            .init(sku: "N6308", countOfTransactions: 408, generalMountOfGBP: 9600.308036697248),
            .init(sku: "A0911", countOfTransactions: 424, generalMountOfGBP: 9603.608201834859),
            .init(sku: "O7730", countOfTransactions: 440, generalMountOfGBP: 9774.773559633028),
            .init(sku: "R9704", countOfTransactions: 451, generalMountOfGBP: 10315.359266055037),
            .init(sku: "M3474", countOfTransactions: 422, generalMountOfGBP: 9657.96785321101),
            .init(sku: "J4064", countOfTransactions: 429, generalMountOfGBP: 9963.739761467901),
            .init(sku: "G7340", countOfTransactions: 450, generalMountOfGBP: 10356.076853211007),
            .init(sku: "C7156", countOfTransactions: 441, generalMountOfGBP: 10142.158458715609)
        ]
    }
}

