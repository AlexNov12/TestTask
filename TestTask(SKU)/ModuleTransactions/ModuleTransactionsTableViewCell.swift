//
//  ModuleTransactionsTableViewCell.swift
//  TestTask(SKU)
//
//  Created by Александр Новиков on 31.08.2024.
//

import UIKit

final class ModuleTransactionsTableViewCell: UITableViewCell {
    
    static let transactionCell = "ModuleTransactionsTableViewCell"
    
    struct Model {
        let amount: String
        let convertedToGBP: String
    }
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private lazy var convertedToGBPLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
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
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with model: Model) {
        amountLabel.text = model.amount
        convertedToGBPLabel.text = model.convertedToGBP
    }
}

private extension ModuleTransactionsTableViewCell {
    func setupSubviews() {
        contentView.addSubview(amountLabel)
        contentView.addSubview(convertedToGBPLabel)
        contentView.addSubview(line)
        setupConstraints()
    }
    
    func setupConstraints() {
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        convertedToGBPLabel.translatesAutoresizingMaskIntoConstraints = false
        line.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            amountLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            amountLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            convertedToGBPLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            convertedToGBPLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            line.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            line.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            line.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            line.heightAnchor.constraint(equalToConstant: 1.0 / UIScreen.main.scale)
        ])
    }
}

