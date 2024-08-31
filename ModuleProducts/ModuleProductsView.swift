//
//  ModuleProductsView.swift
//  TestTask(SKU)
//
//  Created by Александр Новиков on 31.08.2024.
//

import UIKit

final class ModuleProductsView: UIView {
    
    // Используем typealias, что бы было красиво и удобно :)
    typealias Item = ModuleProductsTableViewCell.Model
    
    // Модель через которую передают все изменения во View/TableView
    struct Model {
        let items: [Item]
    }
    
    private var model: Model?
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.register(ModuleProductsTableViewCell.self, forCellReuseIdentifier: ModuleProductsTableViewCell.product)
        view.separatorInset = .zero
        view.tableFooterView = UIView()
        view.backgroundColor = .systemBackground
        view.separatorStyle = .none
        view.showsVerticalScrollIndicator = false
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    private let presenter: ModuleProductsPresenterProtocol
    
    init(presenter: ModuleProductsPresenterProtocol){
        self.presenter = presenter
        super.init(frame: .zero)
        commonInit()
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(model: Model) {
        self.model = model
        tableView.reloadData()
    }
    
    func showError() {
        // Показываем View ошибки
    }
    
    func showEmpty() {
        // Показываем какой-то View для Empty state
    }
    
    func startLoader() {
        // Показываем скелетон или лоадер
    }
    
    func stopLoader() {
        // Скрываем все
    }
}

// MARK: - UITableViewDataSource
extension ModuleProductsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = model, let cell = tableView.dequeueReusableCell(withIdentifier: ModuleProductsTableViewCell.product) as?
                ModuleProductsTableViewCell else {
                return UITableViewCell()
        }
        
        let item = model.items[indexPath.row]
        
        let cellModel = ModuleProductsTableViewCell.Model(
            sku: item.sku,
            countOfTransactions: item.countOfTransactions,
            generalMountOfGBP: nil
        )
        cell.update(with: cellModel)
        return cell
    }
}

// MARK: - UITableViewDelegate
// Нужен будет потом для перехода на второй модуль
extension ModuleProductsView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
//        presenter.tap
    }
}

private extension ModuleProductsView {
    
    func commonInit() {
        backgroundColor = .systemBackground
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.0),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}























