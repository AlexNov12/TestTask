//
//  ProductModels.swift
//  TestTask(SKU)
//
//  Created by Александр Новиков on 31.08.2024.
//

import Foundation

struct RateResponse: Decodable {
    let from: String
    let rate: String
    let to: String
}

struct TransactionResponse: Decodable {
    let amount: String
    let currency: String
    let sku: String
}

struct ProductModel {
    let sku: String
    let transactions: [Transaction]
}

struct Transaction {
    let amount: String
    let currency: String
    let amountInGBP: String
}

struct FromTo: Hashable {
    let from: Currency
    let to: Currency
}

struct Currency: Hashable {
    let code: String
}

