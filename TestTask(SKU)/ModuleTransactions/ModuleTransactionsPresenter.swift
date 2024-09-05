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
    
    init(context: ModuleTransactionsFactory.Context) {
        self.context = context
    }
    
    func viewDidLoad() {
        updateUI()
    }
}

private extension ModuleTransactionsPresenter {
    func updateUI() {
    
        let totalInGBP = context.transactions.reduce(0.0) { $0 + $1.amountInGBP }
        let totalFormatted = formater.gbp + formater.format2f(totalInGBP)
        
        
        // Вот тут у нас должны передаваться строки в конструктор
        let items: [ModuleTransactionsTableViewCell.Model] = context.transactions.map {
            .init(
                amount: formater.makeSymbol(for: $0.currency) + formater.format2f($0.amount),
                convertedToGBP: formater.gbp + formater.format2f($0.amountInGBP)
            )
        }
        
        let viewModel: ModuleTransactionsView.Model = .init(items: items, total: totalFormatted)
        
        view?.update(model: viewModel)
        
    }
}
