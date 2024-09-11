//
//  Converter.swift
//  TestTask(SKU)
//
//  Created by Александр Новиков on 02.09.2024.
//

import Foundation

protocol ConverterProtocol {
    func convertToGBP(amount: String, fromCurrency: CurrencyCode) -> Double
}

final class Converter: ConverterProtocol {

    private var currencies = [FromTo: Double]()
    private let rateProvider: CurrencyRateProviderProtocol
    
    init(rateProvider: CurrencyRateProviderProtocol) {
        self.rateProvider = rateProvider
        self.currencies = rateProvider.getCurrencyRates()
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

        return (Double(amount) ?? 0.0) * result
        
    }
}
