//
//  ProductCreator.swift
//  TestTask(SKU)
//
//  Created by Александр Новиков on 03.09.2024.
//

import Foundation

final class ProductCreator {
    func createProducts(from transactions: [TransactionResponse], converter: Converter) -> [ProductModel] {
    
        var skuDict = [String: [Transaction]]()

        
        for transaction in transactions {
            let amountInGBP = converter.convertToGBP(
                amount: transaction.amount,
                currency: transaction.currency
            )
            let newTransaction = Transaction(
                amount: transaction.amount,
                currency: transaction.currency,
                amountInGBP: amountInGBP
            )
            
            if var existingTransactions = skuDict[transaction.sku]{
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
