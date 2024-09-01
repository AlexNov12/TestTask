//
//  ModuleProductsRouter.swift
//  TestTask(SKU)
//
//  Created by Александр Новиков on 31.08.2024.
//

import Foundation
import UIKit

// Роутер, который открывает все переходы с модуля Products

protocol ModuleProductsRouterProtocol: AnyObject {
    
    // Модуль Products показывает модуль Transactions и передает в него параметры.
    // Нужно добавить SKU и [TransactionsForSKU]
    func openModuleTransactions(sku: String, total: String, transactions: [TransactionsForSKU])
}

final class ModuleProductsRouter:ModuleProductsRouterProtocol {
    
    private let factory: ModuleTransactionsFactory
    
    private weak var root: UIViewController?
    
    init(factory: ModuleTransactionsFactory) {
        self.factory = factory
    }
    
    func setRootViewController(root: UIViewController) {
        self.root = root
    }
    
    // Модуль Products показывает модуль Transactions и передает в него параметры.
    // Нужно добавить SKU и [TransactionsForSKU]
    func openModuleTransactions(sku: String, total: String, transactions: [TransactionsForSKU]) {
        
        let context = ModuleTransactionsFactory.Context(
            sku: "sd",
            total: "Sd",
            transactions: []
        )
        
        let viewController = factory.make()
//        let viewController = factory.make(context: context)
        
        root?.navigationController?.pushViewController(viewController, animated: true)
    }
}

