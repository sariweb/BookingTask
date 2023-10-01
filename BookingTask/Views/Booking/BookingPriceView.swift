//
//  BookingPriceView.swift
//  BookingTask
//
//  Created by Sergei on 30.09.2023.
//

import UIKit

final class BookingPriceView: UIView {
    
    public var tourPrice: Int? {
        didSet {
            tourDataLabel.text = makePriceString(tourPrice)
        }
    }

    public var fuelCharge: Int? {
        didSet {
            fuelChargeDataLabel.text = makePriceString(fuelCharge)
        }
    }

    public var serviceCharge: Int? {
        didSet {
            serviceChargeDataLabel.text = makePriceString(serviceCharge)
        }
    }
    
    public var paymentSum: Int? {
        didSet {
            paymentDataLabel.text = makePriceString(paymentSum)
        }
    }

    private var tourLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.descriptionFont
        label.textColor = Theme.descriptionColor
        label.text = "Тур"
        
        return label
    }()
    
    private var tourDataLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.descriptionFont
        label.textColor = .label
        
        return label
    }()
    
    private var fuelChargeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.descriptionFont
        label.textColor = Theme.descriptionColor
        label.text = "Топливный сбор"
        
        return label
    }()
    
    private var fuelChargeDataLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.descriptionFont
        label.textColor = .label
        
        return label
    }()
    
    private var serviceChargeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.descriptionFont
        label.textColor = Theme.descriptionColor
        label.text = "Сервисный сбор"
        
        return label
    }()
    
    private var serviceChargeDataLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.descriptionFont
        label.textColor = .label
        
        return label
    }()
    
    private var paymentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.descriptionFont
        label.textColor = Theme.descriptionColor
        label.text = "К оплате"
        
        return label
    }()
    
    private var paymentDataLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.paymentFont
        label.textColor = Theme.buttonColor
        
        return label
    }()

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 12
        backgroundColor = .white
        
        addSubview(tourLabel)
        addSubview(fuelChargeLabel)
        addSubview(serviceChargeLabel)
        addSubview(paymentLabel)
        addSubview(tourDataLabel)
        addSubview(fuelChargeDataLabel)
        addSubview(serviceChargeDataLabel)
        addSubview(paymentDataLabel)

        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makePriceString(_ price: Int?) -> String {
        return "\(price ?? 0)" + " ₽"
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            tourLabel.topAnchor.constraint(equalTo: topAnchor, constant: Theme.margin),
            tourLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Theme.margin),
            
            tourDataLabel.topAnchor.constraint(equalTo: topAnchor, constant: Theme.margin),
            tourDataLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Theme.margin),
            
            fuelChargeLabel.topAnchor.constraint(equalTo: tourDataLabel.bottomAnchor, constant: Theme.margin),
            fuelChargeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Theme.margin),
            
            fuelChargeDataLabel.topAnchor.constraint(equalTo: fuelChargeLabel.topAnchor),
            fuelChargeDataLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Theme.margin),
            
            serviceChargeLabel.topAnchor.constraint(equalTo: fuelChargeDataLabel.bottomAnchor, constant: Theme.margin),
            serviceChargeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Theme.margin),
            
            serviceChargeDataLabel.topAnchor.constraint(equalTo: serviceChargeLabel.topAnchor),
            serviceChargeDataLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Theme.margin),
            
            paymentLabel.topAnchor.constraint(equalTo: serviceChargeDataLabel.bottomAnchor, constant: Theme.margin),
            paymentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Theme.margin),
            
            paymentDataLabel.topAnchor.constraint(equalTo: paymentLabel.topAnchor),
            paymentDataLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Theme.margin),

            heightAnchor.constraint(greaterThanOrEqualToConstant: 156),
        ])
    }
}
