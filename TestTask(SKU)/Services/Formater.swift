//
//  Formater.swift
//  TestTask(SKU)
//
//  Created by Александр Новиков on 02.09.2024.
//

import Foundation

final class Formater {
    func format2fGBP(_ number: Double) -> String {
        return String(format: "£%.2f", number)
    }
    func format2f(_ number: Double) -> String {
        return String(format: "%.2f", number)
    }
}
