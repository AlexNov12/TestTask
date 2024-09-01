//
//  ModuleTransactionsFactory.swift
//  TestTask(SKU)
//
//  Created by Александр Новиков on 31.08.2024.
//

import UIKit

final class ModuleTransactionsFactory {
    
    // В структуре параметры, которые мы хотим передать в модуль.
    struct Context {
        let sku: String
        let total: String
        let transactions: [TransactionsForSKU]
    }
    
    func make() -> UIViewController {
        let service = TransactionsService()
        
        let presenter = ModuleTransactionsPresenter(
            service: service
        )
        
        let vc = ModuleTransactionsViewController(presenter: presenter)

        presenter.view = vc
        
        return vc
    }
}
