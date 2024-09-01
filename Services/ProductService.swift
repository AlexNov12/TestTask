//
//  ProductServices.swift
//  TestTask(SKU)
//
//  Created by Александр Новиков on 31.08.2024.
//

import Foundation

protocol ProductServiceProtocol {
    func requestProducts(completion: @escaping (Result<[ProductsModel], Error>) -> ())
    func getTransactions(for sku: String) -> [TransactionsForSKU]
}

final class ProductService: ProductServiceProtocol {
    
    private var rates: [Rate] = []
    private var transactions: [Transaction] = []
    private var conversionInGBP: [String: Double] = [:]
    
    // Функция для загрузки данных из plist
    private func receiveData<T: Decodable>(resource: String, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        DispatchQueue.global().async {
            guard let url = Bundle.main.url(forResource: resource, withExtension: "plist") else {
                DispatchQueue.main.async {
                    completion(.failure(NSError(domain: "Invalid resource", code: 0, userInfo: nil)))
                }
                return
            }
            do {
                let data = try Data(contentsOf: url)
                let result = try PropertyListDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    func requestProducts(completion: @escaping (Result<[ProductsModel], Error>) -> ()) {
        // Здесь загружаем данные из plist и обрабатываем их
        let group = DispatchGroup()
        var ratesResult: Result<[Rate], Error>?
        var transactionsResult: Result<[Transaction], Error>?
        
        group.enter()
        loadRates { result in
            ratesResult = result
            group.leave()
        }
        
        group.enter()
        loadTransactions { result in
            transactionsResult = result
            group.leave()
        }
        
        group.notify(queue: .main) {
            switch (ratesResult, transactionsResult) {
            case (.success(let rates), .success(let transactions)):
                self.rates = rates
                self.transactions = transactions
                self.setupConversionRates()
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
    }
    
    private func loadRates(completion: @escaping (Result<[Rate], Error>) -> Void) {
        receiveData(resource: "rates", type: [Rate].self, completion: completion)
    }
    
    private func loadTransactions(completion: @escaping (Result<[Transaction], Error>) -> Void) {
        receiveData(resource: "transactions", type: [Transaction].self, completion: completion)
    }
    
    // Настройка курсов конверсии
    private func setupConversionRates() {
        for rate in rates {
            if rate.to == "GBP", let rateInGBP = Double(rate.rate) {
                conversionInGBP[rate.from] = rateInGBP
            }
        }
        // Пример конверсии через USD для CAD
        if let usdToGbp = conversionInGBP["USD"] {
            let cadToGbp = 1.0 / 1.09 * usdToGbp // Примерная формула, нужно уточнить по требованиям
            conversionInGBP["CAD"] = cadToGbp
        }
        conversionInGBP["GBP"] = 1.0
    }
    
    // Создание массива [ProductsModel]
    private func createProducts(from transactions: [Transaction]) -> [ProductsModel] {
        var skuCounts = [String: Int]()
        var skuAmountsInGBP = [String: Double]()
        
        for transaction in transactions {
            skuCounts[transaction.sku, default: 0] += 1
            
            if let amount = Double(transaction.amount),
               let rate = conversionInGBP[transaction.currency] {
                let amountInGBP = amount * rate
                skuAmountsInGBP[transaction.sku, default: 0.0] += amountInGBP
            }
        }
        
        let products = skuCounts.map { (sku, count) -> ProductsModel in
            let totalGBP = skuAmountsInGBP[sku] ?? 0.0
            return ProductsModel(sku: sku, countOfTransactions: count, generalAmountOfGBP: totalGBP)
        }
        
        return products
    }
    
    func getTransactions(for sku: String) -> [TransactionsForSKU] {
        return transactions
            .filter { $0.sku == sku }
            .compactMap { transaction in
                guard let amount = Double(transaction.amount),
                      let rate = conversionInGBP[transaction.currency] else { return nil }
                let amountInGBP = amount * rate
                return TransactionsForSKU(sku: transaction.sku, currency: transaction.currency, amount: amount, amountInGBP: amountInGBP)
            }
    }
}

