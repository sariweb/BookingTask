//
//  RoomTableViewCell.swift
//  BookingTask
//
//  Created by Sergei on 18.09.2023.
//

import UIKit

class RoomTableViewCell: UITableViewCell {
    static let identifier = "RoomTableViewCell"
    
    private var imageSliderView: ImageSliderView = {
        let view = ImageSliderView()
        
        return view
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.titleFont
        label.textColor = .label
        label.numberOfLines = 0
        
        return label
    }()
    
    private let featuresView: TagLabelsView = {
        let view = TagLabelsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let moreButtonView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Theme.buttonBgColor
        view.layer.cornerRadius = 5
        
        return view
    }()
    
    private var moreButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = Theme.starsFont
        button.titleLabel?.textColor = Theme.textButtonColor
        button.setTitle("Подробнее о номере", for: .normal)

        let configuration = UIImage.SymbolConfiguration(font: Theme.smallButtonFont)
        let image = UIImage(systemName: "chevron.right", withConfiguration: configuration)
        button.setImage(image, for: .normal)
        button.tintColor = Theme.textButtonColor
        
        button.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        button.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        button.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        

        return button
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
    
    private var bottomView: BottomButtonView = {
        let view = BottomButtonView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var wrapperView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: RoomTableViewCell.identifier)

        priceView.addSubview(priceLabel)
        priceView.addSubview(priceDescLabel)
        
        moreButtonView.addSubview(moreButton)
        
        wrapperView.addSubview(imageSliderView)
        wrapperView.addSubview(titleLabel)
        wrapperView.addSubview(featuresView)
        wrapperView.addSubview(moreButtonView)
        wrapperView.addSubview(priceView)
        wrapperView.addSubview(bottomView)
        
        bottomView.buttonTitle = "Выбрать номер"
        
        contentView.addSubview(wrapperView)
        
        contentView.backgroundColor = Theme.wrapperViewColor
        
        addConstraints()
     }

     required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    private func addConstraints() {
        let heightConstraint = titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 52)
            heightConstraint.priority = UILayoutPriority(250)
        
        NSLayoutConstraint.activate([
            imageSliderView.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: Theme.margin),
            imageSliderView.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: Theme.margin),
            imageSliderView.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -Theme.margin),
            imageSliderView.heightAnchor.constraint(equalToConstant: 257),
            
            titleLabel.topAnchor.constraint(equalTo: imageSliderView.bottomAnchor, constant: Theme.margin),
            titleLabel.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: Theme.margin),
            titleLabel.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -Theme.margin),
            heightConstraint,
            
            featuresView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Theme.margin),
            featuresView.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: Theme.margin),
            featuresView.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -Theme.margin),
            
            priceLabel.topAnchor.constraint(equalTo: priceView.topAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: priceView.leadingAnchor),
            priceLabel.bottomAnchor.constraint(equalTo: priceView.bottomAnchor),
            
            priceDescLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 8),
            priceDescLabel.firstBaselineAnchor.constraint(equalTo: priceLabel.firstBaselineAnchor),

            moreButton.centerYAnchor.constraint(equalTo: moreButtonView.centerYAnchor),
            moreButton.leadingAnchor.constraint(equalTo: moreButtonView.leadingAnchor, constant: 10),
            moreButton.trailingAnchor.constraint(equalTo: moreButtonView.trailingAnchor, constant: -6),
            
            moreButtonView.topAnchor.constraint(equalTo: featuresView.bottomAnchor, constant: 8),
            moreButtonView.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: Theme.margin),
            moreButtonView.heightAnchor.constraint(equalToConstant: 29),
            moreButtonView.widthAnchor.constraint(greaterThanOrEqualToConstant: 192),
            
            priceView.topAnchor.constraint(equalTo: moreButton.bottomAnchor, constant: Theme.margin),
            priceView.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: Theme.margin),
            priceView.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -Theme.margin),
            
            bottomView.topAnchor.constraint(equalTo: priceView.bottomAnchor, constant: Theme.margin),
            bottomView.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor, constant: -Theme.margin),
            
            wrapperView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            wrapperView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            wrapperView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            wrapperView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            
        ])
    }
    
    // MARK: Configure cell
    
    public func configure(room: Room) {
        imageSliderView.imageUrls = room.imageUrls
        titleLabel.text = room.name
        featuresView.tagNames = room.peculiarities
        priceLabel.text = "от \(room.price) ₽"
        priceDescLabel.text = room.pricePer
    }
}
