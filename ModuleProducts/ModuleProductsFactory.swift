//
//  ModuleProductsFactory.swift
//  TestTask(SKU)
//
//  Created by Александр Новиков on 31.08.2024.
//

import UIKit

final class ModuleProductsFactory {
    
    // В структуре параметры, которые мы хотим передать в модуль.
    struct Context {
        // Тут пусто, наш модуль ничего не получает
    }
    
    func make() -> UIViewController {
        let service = ProductService()
        
        let router = ModuleProductsRouter(
            factory: ModuleTransactionsFactory()
        )
        
        let presenter = ModuleProductsPresenter(
            service: service, 
            router: router
        )
        
        let vc = ModuleProductsViewController(presenter: presenter)
        
        router.setRootViewController(root: vc)
        presenter.view = vc
        
        return vc
    }
}
