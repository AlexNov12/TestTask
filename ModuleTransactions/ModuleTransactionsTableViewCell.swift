//
//  ModuleTransactionsTableViewCell.swift
//  TestTask(SKU)
//
//  Created by Александр Новиков on 31.08.2024.
//

import UIKit

final class ModuleTransactionsTableViewCell: UITableViewCell {
    
    static let transaction = "ModuleTransactionsTableViewCell"
    
    struct Model {
        let currency: String
        let startAmount: Double
        let amountInGBP: Double
    }
    
    private lazy var startAmountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private lazy var amountInGBPLabel: UILabel = {
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
        switch model.currency {
        case "GBP":
            startAmountLabel.text = ("£\(model.startAmount)")
        case "AUD":
            startAmountLabel.text = ("A$\(model.startAmount)")
        case "CAD":
            startAmountLabel.text = ("CA$\(model.startAmount)")
        default:
            startAmountLabel.text = ("$\(model.startAmount)")
        }
        amountInGBPLabel.text = ("£\(model.amountInGBP)")
    }
}

private extension ModuleTransactionsTableViewCell {
    func setupSubviews() {
        contentView.addSubview(startAmountLabel)
        contentView.addSubview(amountInGBPLabel)
        contentView.addSubview(line)
        setupConstraints()
    }
    
    func setupConstraints() {
        startAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        amountInGBPLabel.translatesAutoresizingMaskIntoConstraints = false
        line.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            startAmountLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            startAmountLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            skuLabel.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 8),
            amountInGBPLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            amountInGBPLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            countOfTransactionsLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8),
            
            line.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            line.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            line.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            line.heightAnchor.constraint(equalToConstant: 1.0 / UIScreen.main.scale)
        ])
    }
}
