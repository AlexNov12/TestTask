//
//  ProductModels.swift
//  TestTask(SKU)
//
//  Created by Александр Новиков on 31.08.2024.
//

import Foundation

struct Rate: Decodable {
    let from: String
    let rate: String
    let to: String
}

struct Transaction: Decodable {
    let amount: String
    let currency: String
    let sku: String
}

struct ProductModel {
    var sku: String
    var countOfTransactions: Int
    var generalAmountOfGBP: Double
}

struct TransactionForSKU {
    var sku : String
    var currency: String
    var amount : Double
    var amountInGBP : Double
}


