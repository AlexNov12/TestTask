//
//  ProductCreator.swift
//  TestTask(SKU)
//
//  Created by Александр Новиков on 03.09.2024.
//

import Foundation

protocol ProductCreatorProtocol {
    func createProducts(from transactions: [TransactionResponse]) -> [ProductModel]
}


final class ProductCreator: ProductCreatorProtocol {
    private let converter: ConverterProtocol
    
    init(converter: ConverterProtocol){
        self.converter = converter
    }
    
    func createProducts(from transactions: [TransactionResponse]) -> [ProductModel] {
        var skuDict = [String: [Transaction]]()
        
        for transaction in transactions {
            let amountInGBP = converter.convertToGBP(
                amount: transaction.amount,
                fromCurrency: transaction.currency
            )
            let newTransaction = Transaction(
                amount: Double(transaction.amount) ?? 0.0,
                currency: transaction.currency,
                amountInGBP: amountInGBP
            )
            if var existingTransactions = skuDict[transaction.sku] {
                existingTransactions.append(newTransaction)
                skuDict[transaction.sku] = existingTransactions
            } else {
                skuDict[transaction.sku] = [newTransaction]
            }

        }
        
        let products = skuDict.map { (sku, transactions) -> ProductModel in
            return ProductModel(
                sku: sku,
                transactions: transactions
            )
        }
        
        return products
    }
}
