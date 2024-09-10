//
//  ModuleProductsPresenter.swift
//  TestTask(SKU)
//
//  Created by Александр Новиков on 31.08.2024.
//

protocol ModuleProductsPresenterProtocol {
    var title: String { get }
    
    func viewDidLoad()
    func tapOnProduct(at index: Int)
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
    
    func tapOnProduct(at index: Int) {
        guard let product = model else { return }
        guard product.indices.contains(index) else { return }
        router.openModuleTransactions(sku: product[index].sku, transactions: product[index].transactions)
    }
    
    func viewDidLoad() {
        service.requestProducts { [weak self] (result: Result<[ProductModel], Error>) in
            guard let self else { return }
            switch result {
            case let .success(model):
                self.model = model.sorted { $0.sku.localizedCaseInsensitiveCompare($1.sku) == .orderedAscending }
                updateUI()
            case .failure:
                print("Error requestProducts")
            }
        }
    }
}

private extension ModuleProductsPresenter {
    func updateUI() {
        guard let model = model, model.count > 0 else { return }
        
        let items: [ModuleProductsTableViewCell.Model] = model.map {
            .init(
                sku: $0.sku,
                count: String($0.transactions.count)
            )
        }
        
        let viewModel: ModuleProductsView.Model = .init(items: items)
        
        view?.update(model: viewModel)
    }
}
