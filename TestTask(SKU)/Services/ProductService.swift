//
//  ProductServices.swift
//  TestTask(SKU)
//
//  Created by Александр Новиков on 31.08.2024.
//

import Foundation

protocol ProductServiceProtocol {
    func requestProducts(completion: @escaping (Result<[ProductModel], Error>) -> ())
    func getTransactions(for sku: String) -> [TransactionForSKU]
}

final class ProductService: ProductServiceProtocol {
    
    private var rates: [Rate] = []
    private var transactions: [Transaction] = []
    private var converter = Converter()
    
    private func receiveData<T: Decodable>(resource: String, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = Bundle.main.url(forResource: resource, withExtension: "plist") else {
            completion(.failure(NSError(domain: "Invalid resource", code: 0, userInfo: nil)))
            return
        }
        do {
            let data = try Data(contentsOf: url)
            let result = try PropertyListDecoder().decode(T.self, from: data)
            completion(.success(result))
        } catch {
            completion(.failure(error))
        }
        
    }
    
    func requestProducts(completion: @escaping (Result<[ProductModel], Error>) -> ()) {
        var ratesResult: Result<[Rate], Error>?
        var transactionsResult: Result<[Transaction], Error>?
        
        loadRates { result in
            ratesResult = result
        }
        
        loadTransactions { result in
            transactionsResult = result
        }
        
        switch (ratesResult, transactionsResult) {
        case (.success(let rates), .success(let transactions)):
            self.rates = rates
            self.transactions = transactions
            self.converter.setupConversionRates(from: rates)
            let products = self.createProducts(from: transactions)
            completion(.success(products))
        case (.failure(let error), _):
            completion(.failure(error))
        case (_, .failure(let error)):
            completion(.failure(error))
        default:
            completion(.failure(NSError(domain: "Unknown Error", code: -1, userInfo: nil)))
        }
    }
    
    private func loadRates(completion: @escaping (Result<[Rate], Error>) -> Void) {
        receiveData(resource: "rates", type: [Rate].self, completion: completion)
    }
    
    private func loadTransactions(completion: @escaping (Result<[Transaction], Error>) -> Void) {
        receiveData(resource: "transactions", type: [Transaction].self, completion: completion)
    }

    private func createProducts(from transactions: [Transaction]) -> [ProductModel] {
        var skuCounts = [String: Int]()
        var skuAmountsInGBP = [String: Double]()
        
        for transaction in transactions {
            skuCounts[transaction.sku, default: 0] += 1
            
            if let amount = Double(transaction.amount),
               let rate = converter.сurrencies[transaction.currency] {
                let amountInGBP = amount * rate
                skuAmountsInGBP[transaction.sku, default: 0.0] += amountInGBP
            }
        }
        
        let products = skuCounts.map { (sku, count) -> ProductModel in
            let totalGBP = skuAmountsInGBP[sku] ?? 0.0
            return ProductModel(sku: sku, countOfTransactions: count, generalAmountOfGBP: totalGBP)
        }
        
        return products
    }

    func getTransactions(for sku: String) -> [TransactionForSKU] {
        return transactions
            .filter { $0.sku == sku }
            .compactMap { transaction in
                guard let amount = Double(transaction.amount),
                      let rate = converter.сurrencies[transaction.currency] else { return nil }
                let amountInGBP = amount * rate
                return TransactionForSKU(sku: transaction.sku, currency: transaction.currency, amount: amount, amountInGBP: amountInGBP)
            }
    }
}

