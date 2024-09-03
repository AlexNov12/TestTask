//
//  ModuleTransactionsViewController.swift
//  TestTask(SKU)
//
//  Created by Александр Новиков on 31.08.2024.
//

import UIKit

protocol ModuleTransactionsViewProtocol: AnyObject {
    func update(model: ModuleTransactionsView.Model)
}

final class ModuleTransactionsViewController: UIViewController {
    
    private let presenter: ModuleTransactionsPresenterProtocol
    private lazy var customView = ModuleTransactionsView(presenter: presenter)
    
    init(presenter: ModuleTransactionsPresenterProtocol) {
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

extension ModuleTransactionsViewController: ModuleTransactionsViewProtocol {
    func update(model: ModuleTransactionsView.Model) {
        customView.update(model: model)
    }
}
