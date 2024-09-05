//
//  Formater.swift
//  TestTask(SKU)
//
//  Created by Александр Новиков on 02.09.2024.
//

import Foundation

final class Formater {

    let locale: NSLocale = NSLocale(localeIdentifier: "en_US")
    
    lazy var gbp = locale.displayName(forKey: .currencySymbol, value: "GBP") ?? ""
    
    func makeSymbol(for currency: String) -> String {
       return locale.displayName(forKey: .currencySymbol, value: currency) ?? currency
    }

    func format2f(_ number: Double) -> String {
        return String(format: "%.2f", number)
    }
    
    func doubleValue(from amountString: String) -> Double {
        if let number = Double(amountString) {
            return number
        } else {
            return 0.0
        }
    }
}
