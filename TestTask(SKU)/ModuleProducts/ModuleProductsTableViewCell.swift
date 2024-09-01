//
//  ModuleProductsTableViewCell.swift
//  TestTask(SKU)
//
//  Created by Александр Новиков on 31.08.2024.
//

import UIKit

final class ModuleProductsTableViewCell: UITableViewCell {
    
    static let product = "ModuleProductsTableViewCell" // product = SKU
    
    struct Model {
        let sku: String
        let countOfTransactions: Int
        let generalMountOfGBP: Double?
    }
    
    private lazy var skuLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private lazy var countOfTransactionsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .gray
        label.textAlignment = .right
        return label
    }()
    
    private lazy var line: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .systemBackground
        backgroundColor = .systemBackground
        selectionStyle = .none
        tintColor = .systemRed
        
        setupSubviews()
        
        accessoryType = .disclosureIndicator
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func update(with model: Model) {
        skuLabel.text = model.sku
        countOfTransactionsLabel.text = ("\(model.countOfTransactions) transactions")
    }
}

private extension ModuleProductsTableViewCell {
    func setupSubviews() {
        contentView.addSubview(skuLabel)
        contentView.addSubview(countOfTransactionsLabel)
        contentView.addSubview(line)
        setupConstraints()
    }
    
    func setupConstraints() {
        skuLabel.translatesAutoresizingMaskIntoConstraints = false
        countOfTransactionsLabel.translatesAutoresizingMaskIntoConstraints = false
        line.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            skuLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            skuLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            countOfTransactionsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            countOfTransactionsLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            line.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            line.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            line.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            line.heightAnchor.constraint(equalToConstant: 1.0 / UIScreen.main.scale)
        ])
    }
}
