//
//  HotelInfoView.swift
//  BookingTask
//
//  Created by Sergei on 30.09.2023.
//

import UIKit

final class HotelInfoView: UIView {
    
    public var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    public var rating: String? {
        didSet {
            starsLabel.text = "★ \(rating ?? "")"
        }
    }
    
    public var address: String? {
        didSet {
            addressButton.setTitle(address, for: .normal)
        }
    }
    
    private var starsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.backgroundColor = Theme.starsViewColor
        return view
    }()
    
    private var starsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.starsFont
        label.textColor = Theme.starsLabelColor
        
        return label
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.titleFont
        label.textColor = .label
        label.numberOfLines = 0
        
        return label
    }()
    
    private var addressButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = Theme.addressFont
        button.titleLabel?.textColor = Theme.textButtonColor
        button.titleLabel?.textAlignment = .left
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -24, bottom: 0, right: 0)

        return button
    }()
    
    private var infoLabelStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 8
        view.distribution = .fill
        view.backgroundColor = .white
        return view
    }()

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 12
        backgroundColor = .white
        
        starsView.addSubview(starsLabel)
        
        infoLabelStackView.addArrangedSubview(titleLabel)
        infoLabelStackView.addArrangedSubview(addressButton)
        
        addSubview(starsView)
        addSubview(infoLabelStackView)

        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            // MARK: - Hotel view constraints
            starsView.topAnchor.constraint(equalTo: topAnchor, constant: Theme.margin),
            starsView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Theme.margin),
            starsView.heightAnchor.constraint(equalToConstant: 29),
            
            starsLabel.topAnchor.constraint(equalTo: starsView.topAnchor, constant: 5),
            starsLabel.leadingAnchor.constraint(equalTo: starsView.leadingAnchor, constant: 10),
            starsLabel.bottomAnchor.constraint(equalTo: starsView.bottomAnchor, constant: -5),
            starsLabel.trailingAnchor.constraint(equalTo: starsView.trailingAnchor, constant: -10),
            
            infoLabelStackView.topAnchor.constraint(equalTo: starsView.bottomAnchor, constant: 8),
            infoLabelStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Theme.margin),
            infoLabelStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Theme.margin),
            
            heightAnchor.constraint(equalToConstant: 152),
        ])
    }
}
