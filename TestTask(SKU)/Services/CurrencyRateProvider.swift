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
    private let dataLoader = DataLoader()
    
    func getCurrencyRates() -> [FromTo: Double] {
        dataLoader.load(resource: "rates", type: [RateResponse].self) { result in
            switch result {
            case .success(let rateResponses):
                for rate in rateResponses {
                    if let rateValue = Double(rate.rate) {
                        self.ratesDict[FromTo(from: rate.from, to: rate.to)] = rateValue
                    }
                }
            case .failure(let error):
                print("Ошибка загрузки курсов валют: \(error)")
            }
        }
        return ratesDict
    }
}
