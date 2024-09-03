//
//  ModuleProductsViewController.swift
//  TestTask(SKU)
//
//  Created by Александр Новиков on 31.08.2024.
//

import UIKit

protocol ModuleProductsViewProtocol: AnyObject {
    func update(model: ModuleProductsView.Model)
}

final class ModuleProductsViewController: UIViewController {
    
    private let presenter: ModuleProductsPresenterProtocol
    private lazy var customView = ModuleProductsView(presenter: presenter)
    
    init(presenter: ModuleProductsPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = customView
    }
    
    override func viewDidLoad() {
        title = presenter.title
        presenter.viewDidLoad()
    }
}

extension ModuleProductsViewController: ModuleProductsViewProtocol {
    func update(model: ModuleProductsView.Model) {
        customView.update(model: model)
    }
}
