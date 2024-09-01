//
//  CheckForSecondVC.swift
//  TestTask(SKU)
//
//  Created by Александр Новиков on 31.08.2024.
//

import Foundation

protocol TransactionsServiceProtocol {
    func requestTransactions(completion: @escaping (Result<[TransactionsForSKU], Error>) -> ())
}

final class TransactionsService: TransactionsServiceProtocol {
    func requestTransactions(completion: @escaping (Result<[TransactionsForSKU], Error>) -> ()) {
        DispatchQueue.main.async {
            completion(.success(Constants.transactions))
        }
    }
}

private extension TransactionsService {
    enum Constants {
        static let transactions: [TransactionsForSKU] = [
            .init(sku: "X1893", currency: "USD", amount: 20.9, amountInGBP: 15.6),
            .init(sku: "M3474", currency: "CAD", amount: 17.6, amountInGBP: 10.4),
            .init(sku: "M3474", currency: "GBP", amount: 28.1, amountInGBP: 28.1),
            .init(sku: "G7340", currency: "AUD", amount: 27.4, amountInGBP: 15.0)
        ]
    }
}
