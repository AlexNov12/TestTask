//
//  Converter.swift
//  TestTask(SKU)
//
//  Created by Александр Новиков on 02.09.2024.
//

import Foundation

final class Converter {

    private var currencies = ["GBP": 1.00]
    private let dataLoader: LoadData
    private let formater = Formater()

    init(dataLoader: LoadData = LoadData()) {
        self.dataLoader = dataLoader
    }
    
    func setupConversionRates(completion: @escaping (Result<[RateResponse], Error>) -> Void) {
        dataLoader.loadRates { ratesResult in
            switch ratesResult {
            case .success(let rates):
                let currenciesSet = Set(rates.map {$0.from} + rates.map {$0.to})
                for currency in currenciesSet  {
                    let rateTo = rates.filter { $0.to == "GBP" && $0.from == currency }
                    if !rateTo.isEmpty{
                        self.currencies[currency] = Double(rateTo[0].rate)
                    } else {
                        let rateToUSD = rates.filter { $0.to == currency && $0.from == "USD" }
                        let rateFromUSDToGBP = rates.filter { $0.to == "GBP" && $0.from == "USD" }
                        if let rateTo = rateToUSD.first?.rate,
                           let rateFrom = rateFromUSDToGBP.first?.rate,
                           let rateToValue = Double(rateTo),
                           let rateFromValue = Double(rateFrom) {
                            self.currencies[currency] = rateFromValue / rateToValue
                        }
                    }
                }
                completion(.success(rates))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func convertToGBP(amount: String, currency: String) -> String {
        guard let amountValue = Double(amount), let rate = currencies[currency] else { return "0.00" }
        let amountInGBP = amountValue * rate
        return formater.format2f(amountInGBP)
    }
}



