//
//  BookingTouristView.swift
//  BookingTask
//
//  Created by Sergei on 29.09.2023.
//

import UIKit

class BookingTouristView: UIView {

//    private let viewModel = BookingTouristViewViewModel()
    
    private var isExpanded = false
    
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
        button.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Theme.buttonBgColor
        button.titleLabel?.textColor = Theme.textButtonColor
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(didTapExpand), for: .touchUpInside)
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

    lazy private var nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Имя"
        textField.backgroundColor = Theme.wrapperViewColor
        textField.layer.cornerRadius = 10
        textField.paddingLeft(inset: Theme.margin)
        textField.heightAnchor.constraint(equalToConstant: 52).isActive = true
        
        return textField
    }()
    
    lazy private var surnameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Фамилия"
        textField.backgroundColor = Theme.wrapperViewColor
        textField.layer.cornerRadius = 10
        textField.paddingLeft(inset: Theme.margin)
        textField.heightAnchor.constraint(equalToConstant: 52).isActive = true
        
        return textField
    }()
    
    lazy private var birthDateTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Дата рождения"
        textField.backgroundColor = Theme.wrapperViewColor
        textField.layer.cornerRadius = 10
        textField.paddingLeft(inset: Theme.margin)
        textField.heightAnchor.constraint(equalToConstant: 52).isActive = true
        
        return textField
    }()
    
    lazy private var citizenshipTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Гражданство"
        textField.backgroundColor = Theme.wrapperViewColor
        textField.layer.cornerRadius = 10
        textField.paddingLeft(inset: Theme.margin)
        textField.heightAnchor.constraint(equalToConstant: 52).isActive = true
        
        return textField
    }()
    
    lazy private var passportNumberTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Номер загранпаспорта"
        textField.backgroundColor = Theme.wrapperViewColor
        textField.layer.cornerRadius = 10
        textField.paddingLeft(inset: Theme.margin)
        textField.heightAnchor.constraint(equalToConstant: 52).isActive = true
        
        return textField
    }()
    
    lazy private var passportEspDateField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Срок действия загранпаспорта"
        textField.backgroundColor = Theme.wrapperViewColor
        textField.layer.cornerRadius = 10
        textField.paddingLeft(inset: Theme.margin)
        textField.heightAnchor.constraint(equalToConstant: 52).isActive = true
        
        return textField
    }()
    
    lazy private var textFieldsStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 8
        
        view.addArrangedSubview(nameTextField)
        view.addArrangedSubview(surnameTextField)
        view.addArrangedSubview(birthDateTextField)
        view.addArrangedSubview(citizenshipTextField)
        view.addArrangedSubview(passportNumberTextField)
        view.addArrangedSubview(passportEspDateField)

        return view
    }()
    
    lazy private var wrapperStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = Theme.margin

        return view
    }()

    private(set) var intrinsicHeight: CGFloat = 58
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 8
        backgroundColor = .white
        
        titleView.addSubview(titleLabel)
        titleView.addSubview(expandButton)
        
        wrapperStackView.addArrangedSubview(titleView)
        wrapperStackView.addArrangedSubview(textFieldsStackView)
        wrapperStackView.addArrangedSubview(UIView(frame: .zero))

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

            wrapperStackView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: Theme.margin),
            wrapperStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Theme.margin),
            wrapperStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Theme.margin),
            wrapperStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            heightAnchor.constraint(greaterThanOrEqualToConstant: 58)
        ])
    }

    @objc private func didTapExpand() {
        isExpanded = !isExpanded
        let systemName = isExpanded ?  "chevron.down" : "chevron.up"
        
        intrinsicHeight = isExpanded ? 58 : (58 + 60 * 6)
        invalidateIntrinsicContentSize()
        
        UIView.animate(withDuration: 0.5) {
            self.expandButton.setImage(UIImage(systemName: systemName), for: .normal)
            self.textFieldsStackView.isHidden = self.isExpanded
        }
    }
    
    override var intrinsicContentSize: CGSize {
        var sz = super.intrinsicContentSize
        sz.height = intrinsicHeight
        
        return sz
    }
}
