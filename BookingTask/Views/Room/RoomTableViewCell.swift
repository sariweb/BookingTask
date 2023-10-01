//
//  RoomTableViewCell.swift
//  BookingTask
//
//  Created by Sergei on 18.09.2023.
//

import UIKit

protocol RoomTableViewCellDelegate: AnyObject {
    func didTapButton(with id: Int)
}

class RoomTableViewCell: UITableViewCell {
    static let identifier = "RoomTableViewCell"
    
    weak var delegate: RoomTableViewCellDelegate?
    
    private var id: Int?
    
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
        
        return view
    }()
    
    private let moreButtonView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Theme.buttonBgColor
        view.layer.cornerRadius = 5
        
        return view
    }()
    
    private let moreButtonStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .center
        view.distribution = .equalSpacing
        
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

    private var priceView: PriceView = {
        let view = PriceView()
        
        return view
    }()
    
    private var transitionButtonView: TransitionButtonView = {
        let view = TransitionButtonView()

        return view
    }()
    
    private var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 8
        
        return view
    }()
    
    private var wrapperView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        view.backgroundColor = .white
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: RoomTableViewCell.identifier)
        
        moreButtonView.addSubview(moreButton)
        moreButtonStackView.addArrangedSubview(moreButtonView)
        moreButtonStackView.addArrangedSubview(UIView(frame: .zero))
        
        stackView.addArrangedSubview(imageSliderView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(featuresView)
        stackView.addArrangedSubview(moreButtonStackView)
        stackView.addArrangedSubview(priceView)
        
        wrapperView.addSubview(stackView)
        wrapperView.addSubview(transitionButtonView)
        
        transitionButtonView.delegate = self
        transitionButtonView.buttonTitle = "Выбрать номер"
        
        contentView.addSubview(wrapperView)
        contentView.backgroundColor = Theme.wrapperViewColor
        
        addConstraints()
     }

     required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            moreButtonView.heightAnchor.constraint(equalToConstant: 29),
            moreButtonView.widthAnchor.constraint(equalToConstant: 192),
            moreButton.centerYAnchor.constraint(equalTo: moreButtonView.centerYAnchor),
            moreButton.leadingAnchor.constraint(equalTo: moreButtonView.leadingAnchor, constant: 10),
            
            stackView.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: Theme.margin),
            stackView.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: Theme.margin),
            stackView.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -Theme.margin),
            
            transitionButtonView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: Theme.margin),
            transitionButtonView.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: Theme.margin),
            transitionButtonView.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -Theme.margin),
            transitionButtonView.bottomAnchor.constraint(greaterThanOrEqualTo: wrapperView.bottomAnchor, constant: -Theme.margin),
            
            wrapperView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            wrapperView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            wrapperView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            wrapperView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor),
            wrapperView.heightAnchor.constraint(greaterThanOrEqualToConstant: 539),
        ])
    }
    
    // MARK: Configure cell
    
    public func configure(room: Room) {
        imageSliderView.imageUrls = room.imageUrls
        titleLabel.text = room.name
        featuresView.tagNames = room.peculiarities
        priceView.price = "\(room.price) ₽"
        priceView.priceDesc = room.pricePer
        id = room.id
    }
}

extension RoomTableViewCell: TransitionButtonViewDelegate {
    func didTapButton() {
        guard let id else { return }
        delegate?.didTapButton(with: id)
    }
}
