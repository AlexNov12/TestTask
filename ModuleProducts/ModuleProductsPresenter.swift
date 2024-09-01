//
//  ModuleProductsPresenter.swift
//  TestTask(SKU)
//
//  Created by Александр Новиков on 31.08.2024.
//

protocol ModuleProductsPresenterProtocol {
    var title: String { get }
    var analiticScreenName: String { get }
    
    func viewDidLoad()
}

final class ModuleProductsPresenter: ModuleProductsPresenterProtocol {
    
    weak var view: ModuleProductsViewProtocol?
    
    var title: String { "Products" }
    var analiticScreenName: String { "products_module_screen_name" }
    
    private let service: ProductServiceProtocol
    private var model: [ProductsModel]?
    
    init(service: ProductServiceProtocol) {
        self.service = service
    }
    
    func viewDidLoad() {
        view?.stopLoader()
        service.requestProducts { [weak self] (result: Result<[ProductsModel], Error>) in
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

private extension ModuleProductsPresenter {
    func updateUI() {
        guard let model = model, model.count > 0 else { return }
        
        let items: [ModuleProductsTableViewCell.Model] = model.map {
            .init(
                sku: $0.sku,
                countOfTransactions: $0.countOfTransactions,
                generalMountOfGBP: nil
            )
        }
        
        let viewModel: ModuleProductsView.Model = .init(items: items)
        
        view?.update(model: viewModel)
    }
}
