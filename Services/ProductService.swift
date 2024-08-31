//
//  ProductServices.swift
//  TestTask(SKU)
//
//  Created by Александр Новиков on 31.08.2024.
//

import Foundation


protocol ProductServiceProtocol {
    func requestProducts(completion: @escaping (Result<[Products], Error>) -> ())
}
