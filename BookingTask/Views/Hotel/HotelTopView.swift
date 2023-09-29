//
//  HotelTopView.swift
//  BookingTask
//
//  Created by Sergei on 15.09.2023.
//

import UIKit

class HotelTopView: UIView {
    public var topData: HotelTopViewViewModel? {
        didSet {
            guard let topData else { return }
            starsLabel.text = "★ \(topData.rating) \(topData.ratingName)"
            titleLabel.text = "\(topData.name)"
            addressButton.setTitle(topData.adress, for: .normal)
            priceLabel.text = "от \(topData.minimalPrice) ₽"
            priceDescLabel.text = "\(topData.priceForIt)"
            imageSliderView.imageUrls = topData.imageUrls
        }
    }
    
    private var imageSliderView: ImageSliderView = {
        let view = ImageSliderView()
        
        return view
    }()
    
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
    
    private var priceView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = Theme.margin
        clipsToBounds = true
        backgroundColor = .white

        starsView.addSubview(starsLabel)
        
        infoLabelStackView.addArrangedSubview(titleLabel)
        infoLabelStackView.addArrangedSubview(addressButton)
        
        priceView.addSubview(priceLabel)
        priceView.addSubview(priceDescLabel)
        
        addSubview(imageSliderView)
        addSubview(starsView)
        addSubview(infoLabelStackView)
        addSubview(priceView)
        
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            imageSliderView.topAnchor.constraint(equalTo: topAnchor),
            imageSliderView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Theme.margin),
            imageSliderView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Theme.margin),
            imageSliderView.heightAnchor.constraint(equalToConstant: 257),
            
            starsView.topAnchor.constraint(equalTo: imageSliderView.bottomAnchor, constant: Theme.margin),
            starsView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Theme.margin),
            starsView.heightAnchor.constraint(equalToConstant: 29),
            
            starsLabel.topAnchor.constraint(equalTo: starsView.topAnchor, constant: 5),
            starsLabel.leadingAnchor.constraint(equalTo: starsView.leadingAnchor, constant: 10),
            starsLabel.bottomAnchor.constraint(equalTo: starsView.bottomAnchor, constant: -5),
            starsLabel.trailingAnchor.constraint(equalTo: starsView.trailingAnchor, constant: -10),
            
            priceLabel.topAnchor.constraint(equalTo: priceView.topAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: priceView.leadingAnchor),
            priceLabel.bottomAnchor.constraint(equalTo: priceView.bottomAnchor),
            
            priceDescLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 8),
            priceDescLabel.firstBaselineAnchor.constraint(equalTo: priceLabel.firstBaselineAnchor),
            
            infoLabelStackView.topAnchor.constraint(equalTo: starsView.bottomAnchor, constant: 8),
            infoLabelStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Theme.margin),
            infoLabelStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Theme.margin),
            
            priceView.topAnchor.constraint(equalTo: infoLabelStackView.bottomAnchor, constant: Theme.margin),
            priceView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Theme.margin),
            priceView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Theme.margin),
            priceView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Theme.margin),
        ])
    }
}
