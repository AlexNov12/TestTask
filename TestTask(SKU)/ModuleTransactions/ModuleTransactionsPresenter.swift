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
    
        let totalInGBP = context.transactions.reduce(0.0) { $0 + Double($1.amountInGBP)! }
        let totalFormatted = formater.format2fGBP(totalInGBP)
        
        let items: [ModuleTransactionsTableViewCell.Model] = context.transactions.map {
            .init(
                amount: formater.format2f(Double($0.amount) ?? 0),
                convertedToGBP: formater.format2fGBP(Double($0.amountInGBP) ?? 0) //
            )
        }
        
        let viewModel: ModuleTransactionsView.Model = .init(items: items, total: totalFormatted)
        
        view?.update(model: viewModel)
        
    }
}
