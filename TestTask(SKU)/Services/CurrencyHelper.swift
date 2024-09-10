//
//  CurrencyHelper.swift
//  TestTask(SKU)
//
//  Created by Александр Новиков on 09.09.2024.
//

import Foundation

final class CurrencyHelper {

    let locale: NSLocale = NSLocale(localeIdentifier: "en_US")
    
    lazy var gbp = locale.displayName(forKey: .currencySymbol, value: "GBP") ?? ""
    
    func makeSymbol(for currency: String) -> String {
       return locale.displayName(forKey: .currencySymbol, value: currency) ?? currency
    }
}
