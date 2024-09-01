//
//  ModuleTransactionsRouter.swift
//  TestTask(SKU)
//
//  Created by Александр Новиков on 31.08.2024.
//

import UIKit

protocol ModuleTransactionsRouterProtocol: AnyObject {
    
}

final class ModuleTransactionsRouter: ModuleTransactionsRouterProtocol {
    private weak var viewController: UIViewController?

    init(viewController: UIViewController?) {
        self.viewController = viewController
    }

    
}
