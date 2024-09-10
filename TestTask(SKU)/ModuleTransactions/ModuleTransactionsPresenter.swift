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
    private let currencyHelper = CurrencyHelper()

    var title: String { "Transactions for \(sku)" }
    
    private let sku: String
    private let transactions: [Transaction]
    
    init(
        sku: String,
        transactions: [Transaction]
    ) {
        self.sku = sku
        self.transactions = transactions
    }
    
    func viewDidLoad() {
        updateUI()
    }
}

private extension ModuleTransactionsPresenter {
    func updateUI() {
        
        var totalInGBP = 0.0
        var items = [ModuleTransactionsTableViewCell.Model]()
        
        for transaction in transactions {
            totalInGBP += transaction.amountInGBP
            items.append(
                .init(
                    amount: currencyHelper.makeSymbol(for: transaction.currency) + formater.format2f(transaction.amount),
                    amountInGBP: currencyHelper.gbp + formater.format2f(transaction.amountInGBP)
                )
            )
        }
        
        let totalFormatted = currencyHelper.gbp + formater.format2f(totalInGBP)
        let viewModel: ModuleTransactionsView.Model = .init(items: items, total: totalFormatted)
        
        view?.update(model: viewModel)
        
    }
}
