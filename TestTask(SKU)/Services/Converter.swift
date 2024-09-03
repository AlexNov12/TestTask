//
//  Converter.swift
//  TestTask(SKU)
//
//  Created by Александр Новиков on 02.09.2024.
//

import Foundation

struct Converter {
    var сurrencies = ["GBP": 1.00]
    
    mutating func setupConversionRates(from rates: [Rate]) {
        let currenciesSet  = Set(rates.map {$0.from} + rates.map {$0.to})
        for сurrency in currenciesSet  {
            let rateTo = rates.filter { $0.to == "GBP" && $0.from == сurrency }
            if !rateTo.isEmpty{
                self.сurrencies[сurrency] = Double(rateTo[0].rate)
            } else {
                let rateToUSD = rates.filter { $0.to == сurrency && $0.from == "USD" }
                let rateFromUSDToGBP = rates.filter { $0.to == "GBP" && $0.from == "USD" }
                if let rateTo = rateToUSD.first?.rate,
                   let rateFrom = rateFromUSDToGBP.first?.rate,
                   let rateToValue = Double(rateTo),
                   let rateFromValue = Double(rateFrom) {
                    сurrencies[сurrency] = rateFromValue / rateToValue
                }
            }
        }
        print(сurrencies)
    }
}



