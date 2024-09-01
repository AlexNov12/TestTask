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

    var title: String { "Transactions for " }
    var analiticScreenName: String { "transactions_module_screen_name" }
    
    private let service: TransactionsServiceProtocol
    private var model: [TransactionsForSKU]?
    
    init(service: TransactionsServiceProtocol){
        self.service = service
    }
    
    func viewDidLoad() {
        view?.stopLoader()
        service.requestTransactions { [weak self] (result: Result<[TransactionsForSKU], Error>) in
            guard let self else { return }
            view?.stopLoader()
            switch result {
            case let .success(model):
                self.model = model
                updateUI()
            case .failure:
                view?.showError()
            }
        }
    }
}

private extension ModuleTransactionsPresenter {
    func updateUI() {
        guard let model = model, model.count > 0 else { return }
        
        let items: [ModuleTransactionsTableViewCell.Model] = model.map {
            .init(
                currency: $0.currency,
                startAmount: $0.amount,
                amountInGBP: $0.amountInGBP
            )
        }
        
        let viewModel: ModuleTransactionsView.Model = .init(items: items)
        
        view?.update(model: viewModel)
        
    }
}
