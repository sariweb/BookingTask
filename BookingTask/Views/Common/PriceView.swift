//
//  PriceView.swift
//  BookingTask
//
//  Created by Sergei on 30.09.2023.
//

import UIKit

final class PriceView: UIView {
    
    public var price: String? {
        didSet {
            priceLabel.text = price
        }
    }

    public var priceDesc: String? {
        didSet {
            priceDescLabel.text = priceDesc
        }
    }
    
    private var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.priceFont
        label.textColor = .label
        
        return label
    }()
    
    private var priceDescLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.descriptionFont
        label.textColor = Theme.descriptionColor
        
        return label
    }()

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        
        addSubview(priceLabel)
        addSubview(priceDescLabel)

        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: topAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            priceLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            priceDescLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 8),
            priceDescLabel.firstBaselineAnchor.constraint(equalTo: priceLabel.firstBaselineAnchor),
            
            heightAnchor.constraint(equalToConstant: 36),
        ])
    }
}
