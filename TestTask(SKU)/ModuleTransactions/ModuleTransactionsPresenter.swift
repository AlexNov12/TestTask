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
    
    init(context: ModuleTransactionsFactory.Context){
        self.context = context
    }
    
    func viewDidLoad() {
        updateUI()
    }
}

private extension ModuleTransactionsPresenter {
    func updateUI() {
    
        let totalInGBP = context.transactions.reduce(0.0) { result, transaction in
            result + (Double(transaction.amountInGBP) ?? 0.0)
        }
        let totalFormatted = formater.format2fWithCurrency(totalInGBP, formater.gbpCurrency)
        
        let items: [ModuleTransactionsTableViewCell.Model] = context.transactions.map {
            .init(
                amount: (formater.currencies[$0.currency] ?? "") + $0.amount,
                convertedToGBP: (formater.currencies[$0.currency] ?? "") + $0.amountInGBP
            )
        }
        
        let viewModel: ModuleTransactionsView.Model = .init(items: items, total: totalFormatted)
        
        view?.update(model: viewModel)
        
    }
}
