//
//  BookingTouristsDataViewTableFooter.swift
//  BookingTask
//
//  Created by Sergei on 13.10.2023.
//

import UIKit

protocol BookingTouristsDataViewTableFooterDelegate: AnyObject {
    func didTapAddTourist()
}

final class BookingTouristsDataViewTableFooter: UITableViewHeaderFooterView {
    static let identifier = "BookingTouristsDataViewTableFooter"
    
    weak var delegate: BookingTouristsDataViewTableFooterDelegate?
    
    lazy private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.titleFont
        label.textColor = .label
        label.text = "Добавить туриста"
        
        return label
    }()
    
    lazy private var expandButton: UIButton = {
        let button = UIButton()
        let configuration = UIImage.SymbolConfiguration(font: Theme.descriptionFont)
        let image = UIImage(systemName: "plus", withConfiguration: configuration)
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Theme.buttonColor
        button.tintColor = .white
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(didTapAdd), for: .touchUpInside)
        button.heightAnchor.constraint(equalToConstant: 32).isActive = true
        button.widthAnchor.constraint(equalToConstant: 32).isActive = true
        
        return button
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.layer.cornerRadius = 12
        contentView.backgroundColor = .white
        contentView.addSubview(titleLabel)
        contentView.addSubview(expandButton)
        addConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapAdd() {
        delegate?.didTapAddTourist()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Theme.margin),
            
            expandButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            expandButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Theme.margin),

            heightAnchor.constraint(equalToConstant: Theme.touristCellHeight),
        ])
    }
}

