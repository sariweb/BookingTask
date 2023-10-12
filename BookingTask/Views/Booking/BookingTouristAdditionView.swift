//
//  BookingTouristAdditionView.swift
//  BookingTask
//
//  Created by Sergei on 30.09.2023.
//

import UIKit

protocol BookingTouristAdditionViewDelegate: AnyObject {
    func didTapAddTourist()
}

class BookingTouristAdditionView: UIView {

    weak var delegate: BookingTouristAdditionViewDelegate?
    
    public var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    lazy private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.titleFont
        label.textColor = .label
        
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
    
    lazy private var titleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        return view
    }()

    lazy private var wrapperStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = Theme.margin

        return view
    }()
    

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 12
        backgroundColor = .white
        
        titleView.addSubview(titleLabel)
        titleView.addSubview(expandButton)

        wrapperStackView.addArrangedSubview(titleView)
        
        addSubview(wrapperStackView)

        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: titleView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
            
            expandButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            expandButton.trailingAnchor.constraint(equalTo: titleView.trailingAnchor),

            wrapperStackView.topAnchor.constraint(equalTo: topAnchor, constant: Theme.margin),
            wrapperStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Theme.margin),
            wrapperStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Theme.margin),
            wrapperStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Theme.margin),
        ])
    }

    @objc private func didTapAdd() {
        delegate?.didTapAddTourist()
    }
}
