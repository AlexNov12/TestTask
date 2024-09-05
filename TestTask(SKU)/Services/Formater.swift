//
//  Formater.swift
//  TestTask(SKU)
//
//  Created by Александр Новиков on 02.09.2024.
//

import Foundation

final class Formater {
    let gbpCurrency = "GBP"
    let usdCurrency = "USD"

    let currencies: [String: String] = [
        "GBP": "£",
        "USD": "$",
        "CAD": "CA$",
        "AUD": "A$"
    ]

    func format2fWithCurrency<T>(_ number: T, _ currency: String) -> String {
        switch number {
        case is String:
            return number as! String
        case is Double:
            if let convert = currencies[currency] {
                return String(format: "\(convert)%.2f", number as! Double)
            } else {
                return String(format: "%.2f", number as! Double)
            }
        default:
            return ""
        }
    }
    func format2f(_ number: Double) -> String {
            return String(format: "%.2f", number)
    }
}
