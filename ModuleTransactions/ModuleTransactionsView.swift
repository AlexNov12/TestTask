//
//  ModuleTransactionsView.swift
//  TestTask(SKU)
//
//  Created by Александр Новиков on 31.08.2024.
//

import UIKit

final class ModuleTransactionsView: UIView {
    
    // Используем typealias, что бы было красиво и удобно :)
    typealias Item = ModuleTransactionsTableViewCell.Model
    
    // Модель через которую передают все изменения во View/TableView
    struct Model {
        let items: [Item]
        let total: String
    }
    
    private var model: Model?
    
    private lazy var totalTransactions: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.register(ModuleTransactionsTableViewCell.self, forCellReuseIdentifier: ModuleTransactionsTableViewCell.transaction)
        view.separatorInset = .zero
        view.tableFooterView = UIView()
        view.backgroundColor = .systemBackground
        view.separatorStyle = .none
        view.showsVerticalScrollIndicator = false
        view.dataSource = self
        return view
    }()
    
    private let presenter: ModuleTransactionsPresenterProtocol
    
    init(presenter: ModuleTransactionsPresenterProtocol){
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
        totalTransactions.text = model.total
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
extension ModuleTransactionsView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = model, let cell = tableView.dequeueReusableCell(withIdentifier: ModuleTransactionsTableViewCell.transaction) as?
                ModuleTransactionsTableViewCell else {
                return UITableViewCell()
        }
        
        let item = model.items[indexPath.row]
        
        let cellModel = ModuleTransactionsTableViewCell.Model(
            currency: item.currency,
            startAmount: item.startAmount,
            amountInGBP: item.amountInGBP
        )
        
        cell.update(with: cellModel)
        return cell
    }
}

private extension ModuleTransactionsView {
    
    func commonInit() {
        backgroundColor = .systemBackground
        setupSubviews()
        setupConstraints()
        setupTotal()
    }
    
    func setupTotal() {
        totalTransactions.text = model?.total ?? "£0.00"
    }
    
    func setupSubviews() {
        addSubview(totalTransactions)
        addSubview(tableView)
    }
    
    func setupConstraints() {
        totalTransactions.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            totalTransactions.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            totalTransactions.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0),
            totalTransactions.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.0),
            totalTransactions.heightAnchor.constraint(equalToConstant: 30),
            
            tableView.topAnchor.constraint(equalTo: totalTransactions.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.0),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
