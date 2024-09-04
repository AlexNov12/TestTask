//
//  ModuleTransactionsFactory.swift
//  TestTask(SKU)
//
//  Created by Александр Новиков on 31.08.2024.
//

import UIKit

final class ModuleTransactionsFactory {
    
    struct Context {
        let sku: String
        let transactions: [Transaction]
    }
    
    func make(context: Context) -> UIViewController {
        
        let presenter = ModuleTransactionsPresenter(
            context: context
        )
        
        let vc = ModuleTransactionsViewController(presenter: presenter)

        presenter.view = vc
        
        return vc
    }
}
