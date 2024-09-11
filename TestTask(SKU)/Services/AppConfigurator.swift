//
//  AppConfigurator.swift
//  TestTask(SKU)
//
//  Created by Александр Новиков on 11.09.2024.
//

import Foundation

final class ProductServiceConfigurator  {
    
    func configureProductService() -> ProductServiceProtocol {
        let dataLoader = DataLoader()
        let currencyRateProvider = CurrencyRateProvider(dataLoader: dataLoader)
        let converter = Converter(rateProvider: currencyRateProvider)
        let productCreator = ProductCreator(converter: converter)
        
        return ProductService(dataLoader: dataLoader, productCreator: productCreator)
    }
}
