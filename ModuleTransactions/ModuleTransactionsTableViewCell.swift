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
                startAmountLabel.text = String(format: "£%.2f", model.startAmount)
            case "AUD":
                startAmountLabel.text = String(format: "A$%.2f", model.startAmount)
            case "CAD":
                startAmountLabel.text = String(format: "CA$%.2f", model.startAmount)
            default:
                startAmountLabel.text = String(format: "$%.2f", model.startAmount)
            }
            amountInGBPLabel.text = String(format: "£%.2f", model.amountInGBP)
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
                amountInGBPLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
                amountInGBPLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                
                line.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                line.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                line.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                line.heightAnchor.constraint(equalToConstant: 1.0 / UIScreen.main.scale)
            ])
        }
    }
