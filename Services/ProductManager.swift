//
//  ParsingData.swift
//  TestTask(SKU)
//
//  Created by Александр Новиков on 31.08.2024.
//

import Foundation


class ParsingData {
    var rates = [Rate]()
    var transactions = [Transaction]()
    var conversionInGBP = [String: Double]()
    
    // Функция для парсинга данных из plist
    func receiveData<T: Decodable>(resource: String, type: T.Type, completion: (T) -> Void) {
        guard let url = Bundle.main.url(forResource: resource, withExtension: "plist") else {return}
        do {
            let data = try Data(contentsOf: url)
            let result = try PropertyListDecoder().decode(T.self, from: data)
            completion(result)
            
        } catch {
            print("Ошибка при декодировании данных из plist: \(error)")
        }
    }
    
    
}
