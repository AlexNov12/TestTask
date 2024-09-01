//
//  ModuleTransactionsPresenter.swift
//  TestTask(SKU)
//
//  Created by Александр Новиков on 31.08.2024.
//

protocol ModuleTransactionsPresenterProtocol {
    var title: String { get }
    var analiticScreenName: String { get }
    
    func viewDidLoad()
}

final class ModuleTransactionsPresenter: ModuleTransactionsPresenterProtocol {
    
    weak var view: ModuleTransactionsViewProtocol?

    var title: String { "Transactions for \(context.sku)" }
    var analiticScreenName: String { "transactions_module_screen_name" }
    
    private let service: TransactionsServiceProtocol
    private let context: ModuleTransactionsFactory.Context
    private var model: [TransactionsForSKU]?
    
    init(service: TransactionsServiceProtocol, context: ModuleTransactionsFactory.Context){
        self.service = service
        self.context = context
    }
    
    func viewDidLoad() {
        view?.stopLoader()
        updateUI()
    }
}

private extension ModuleTransactionsPresenter {
    func updateUI() {
//        guard let model = model, model.count > 0 else { return }
        
        let items: [ModuleTransactionsTableViewCell.Model] = context.transactions.map {
            .init(
                currency: $0.currency,
                startAmount: $0.amount,
                amountInGBP: $0.amountInGBP
            )
        }
        
        let viewModel: ModuleTransactionsView.Model = .init(items: items, total: context.total)
        
        view?.update(model: viewModel)
        
    }
}
