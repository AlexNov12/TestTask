//
//  ModuleTransactionsPresenter.swift
//  TestTask(SKU)
//
//  Created by Александр Новиков on 31.08.2024.
//

protocol ModuleTransactionsPresenterProtocol {
    var title: String { get }
    
    func viewDidLoad()
}

final class ModuleTransactionsPresenter: ModuleTransactionsPresenterProtocol {
    
    weak var view: ModuleTransactionsViewProtocol?
    private let formater = Formater()

    var title: String { "Transactions for \(context.sku)" }
    
    private let context: ModuleTransactionsFactory.Context
    private var model: [TransactionForSKU]?
    
    init(context: ModuleTransactionsFactory.Context){
        self.context = context
    }
    
    func viewDidLoad() {
        updateUI()
    }
}

private extension ModuleTransactionsPresenter {
    func updateUI() {
        
        let items: [ModuleTransactionsTableViewCell.Model] = context.transactions.map {
            .init(
                amount: formater.format2f($0.amount),
                convertedToGBP: formater.format2fGBP($0.amountInGBP)
            )
        }
        
        let viewModel: ModuleTransactionsView.Model = .init(items: items, total: context.total)
        
        view?.update(model: viewModel)
        
    }
}
