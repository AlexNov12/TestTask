//
//  ModuleProductsPresenter.swift
//  TestTask(SKU)
//
//  Created by Александр Новиков on 31.08.2024.
//

protocol ModuleProductsPresenterProtocol {
    var title: String { get }
    
    func viewDidLoad()
    func tapOnProduct(sku: String)
}

final class ModuleProductsPresenter: ModuleProductsPresenterProtocol {
    
    weak var view: ModuleProductsViewProtocol?
    private let router: ModuleProductsRouterProtocol
    
    var title: String { "Products" }
    
    private let service: ProductServiceProtocol
    private var model: [ProductModel]?
    
    init(service: ProductServiceProtocol, router: ModuleProductsRouterProtocol) {
        self.service = service
        self.router = router
    }
    
    //  Метод для обработки нажатия на продукт
    func tapOnProduct(sku: String) {
        guard let product = model?.first(where: { $0.sku == sku }) else { return }
        let total = String(format: "£%.2f", product.generalAmountOfGBP)
        let transactionsForSKU = service.getTransactions(for: sku)
        router.openModuleTransactions(sku: sku, total: total, transactions: transactionsForSKU)
    }
    
    func viewDidLoad() {
        service.requestProducts { [weak self] (result: Result<[ProductModel], Error>) in
            guard let self else { return }
            switch result {
            case let .success(model):
                self.model = model
                updateUI()
            case .failure:
                print("Error requestProducts")
            }
        }
    }
}

private extension ModuleProductsPresenter {
    func updateUI() {
        guard var model = model, model.count > 0 else { return }
        
        model.sort { $0.sku.localizedCaseInsensitiveCompare($1.sku) == .orderedAscending }
        
        let items: [ModuleProductsTableViewCell.Model] = model.map {
            .init(
                sku: $0.sku,
                transactions: String($0.countOfTransactions)
            )
        }
        
        let viewModel: ModuleProductsView.Model = .init(items: items)
        
        view?.update(model: viewModel)
    }
}
