//
//  Converter.swift
//  TestTask(SKU)
//
//  Created by Александр Новиков on 02.09.2024.
//

import Foundation

protocol ConverterProtocol {
    func setupConversionRates(completion: @escaping (Result<[RateResponse], Error>) -> Void)
    var currencies: [FromTo: Double] { get }
}

final class Converter {
    private var currencies = [FromTo: Double]()
    private let formater =  Formater()
    private let dataLoader = DataLoader()
    func setupConversionRates(completion: @escaping (Result<[RateResponse], Error>) -> Void) {
        dataLoader.loadRates { ratesResult in
            switch ratesResult {
            case .success(let rates):
                rates.forEach {
                    let fromCurrency = $0.from
                    let toCurrency = $0.to
                    if let rate = Double($0.rate) {
                        self.currencies[FromTo(
                            from: fromCurrency,
                            to: toCurrency
                        )] = rate
                    }
                }
                    completion(.success(rates))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func convertToGBP(amount: String, fromCurrency: CurrencyCode) -> Double {
        let gbpCurrency: CurrencyCode = "GBP"
        if fromCurrency == gbpCurrency { return Double(amount) ?? 1.00 }
        var result = 0.00

        if let rate = currencies[FromTo(from: fromCurrency, to: gbpCurrency)] {
            result = rate
        } else {
            let usdCurrency: CurrencyCode = "USD"
            if let fromUSD = currencies[FromTo(from: usdCurrency, to: fromCurrency)],
                let toGBP = currencies[FromTo(from: usdCurrency, to: gbpCurrency)] {
                    let newRate = toGBP / fromUSD
                    currencies[FromTo(from: fromCurrency, to: gbpCurrency)] = newRate
                    currencies[FromTo(from: gbpCurrency, to: fromCurrency)] = 1 /  newRate
                    result = newRate
                }
        }
        return formater.doubleValue(from: amount) * result
    }
}
