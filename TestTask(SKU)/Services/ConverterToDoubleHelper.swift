//
//  ConverterToDoubleHelper.swift
//  TestTask(SKU)
//
//  Created by Александр Новиков on 09.09.2024.
//

import Foundation

final class ConverterToDouble {
    func makeDoubleValue(from amountString: String) -> Double {
        if let number = Double(amountString) {
            return number
        } else {
            return 0.0
        }
    }
} 
