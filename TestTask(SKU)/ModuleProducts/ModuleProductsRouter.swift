//
//  ModuleProductsRouter.swift
//  TestTask(SKU)
//
//  Created by Александр Новиков on 31.08.2024.
//

import Foundation
import UIKit


protocol ModuleProductsRouterProtocol: AnyObject {
    
    func openModuleTransactions(sku: String, total: String, transactions: [TransactionForSKU])
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

    func openModuleTransactions(sku: String, total: String, transactions: [TransactionForSKU]) {
        
        let context = ModuleTransactionsFactory.Context(
            sku: sku,
            total: total,
            transactions: transactions
        )
        
        let viewController = factory.make(context: context)
        
        root?.navigationController?.pushViewController(viewController, animated: true)
    }
}

