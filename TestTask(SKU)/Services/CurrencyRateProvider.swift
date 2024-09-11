//
//  CurrencyRateProvider.swift
//  TestTask(SKU)
//
//  Created by Александр Новиков on 09.09.2024.
//

import Foundation

protocol CurrencyRateProviderProtocol {
    func getCurrencyRates() -> [FromTo: Double]
}

final class CurrencyRateProvider: CurrencyRateProviderProtocol {
    private var ratesDict = [FromTo: Double]()
    private let dataLoader: DataLoaderProtocol
    
    init(dataLoader: DataLoaderProtocol) {
        self.dataLoader = dataLoader
        loadCurrencyRates()
    }
    
    private func loadCurrencyRates() {
        let loadedRates = dataLoader.load(resource: "rates", type: [RateResponse].self)
        switch loadedRates {
        case .success(let rateResponses):
            for rate in rateResponses {
                if let rateValue = Double(rate.rate) {
                    ratesDict[FromTo(from: rate.from, to: rate.to)] = rateValue
                }
            }
        case .failure(let error):
            print("Ошибка загрузки курсов валют: \(error)")
            
        }
    }
    
    func getCurrencyRates() -> [FromTo: Double] {
        return ratesDict
    }
}
