//
//  ProductModels.swift
//  TestTask(SKU)
//
//  Created by Александр Новиков on 31.08.2024.
//

import Foundation

// Данные из "rates.plist"
public struct Rate : Decodable {
    let from, rate, to : String
}

// Данные из "transaction.plist"
public struct Transaction : Decodable {
    let amount, currency, sku : String
}

// Структура для первого модуля
public struct ProductsModel {
    var sku: String
    var countOfTransactions: Int
    var generalAmountOfGBP: Double
}

// Структура для второго модуля
public struct TransactionsForSKU {
    var sku : String
    var currency: String
    var amount : Double
    var amountInGBP : Double
}


