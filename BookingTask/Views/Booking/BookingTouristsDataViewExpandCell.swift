//
//  BookingTouristsDataViewExpandCell.swift
//  BookingTask
//
//  Created by Sergei on 04.10.2023.
//

import UIKit

protocol BookingTouristsDataViewExpandCellDelegate: AnyObject {
    func didTapButton(isExpanded: Bool, cellNumber: Int)
}

final class BookingTouristsDataViewExpandCell: UITableViewCell {
    static let identifier = "BookingTouristsDataViewExpandCell"
    
    weak var delegate: BookingTouristsDataViewExpandCellDelegate?
    
    private var isExpanded = true
    private var cellNumber = 0
    
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: BookingTouristsDataViewExpandCell.identifier)

        contentView.layer.cornerRadius = 12
        contentView.backgroundColor = .white
        
        titleView.addSubview(titleLabel)
        titleView.addSubview(expandButton)

        contentView.addSubview(titleView)
        contentView.addSubview(textFieldsStackView)
        
        addConstraints()
     }

     required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    @objc private func didTapExpand() {
        isExpanded = !isExpanded
        
        setExpanded()
        
        delegate?.didTapButton(isExpanded: isExpanded, cellNumber: cellNumber)
    }
    
    private func setExpanded() {
        let systemName = isExpanded ? "chevron.up" : "chevron.down"
        
        self.expandButton.setImage(UIImage(systemName: systemName), for: .normal)
        UIView.animate(withDuration: 0.5) {
            self.textFieldsStackView.isHidden = !self.isExpanded
        }
    }
    
    private func ordinalTitle(_ number: Int) -> String {
        let ordinals = ["Первый","Второй","Третий","Четвертый","Пятый","Шестой","Седьмой","Восьмой","Девятый","Десятый"]
        if number < ordinals.count {
            return "\(ordinals[number]) турист"
        } else {
            return "Еще турист"
        }
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: titleView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
            
            expandButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            expandButton.trailingAnchor.constraint(equalTo: titleView.trailingAnchor),

            titleView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: Theme.margin),
            titleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Theme.margin),
            titleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Theme.margin),
            titleView.bottomAnchor.constraint(greaterThanOrEqualTo: textFieldsStackView.topAnchor, constant: -Theme.margin),
            
            textFieldsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Theme.margin),
            textFieldsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Theme.margin),
            textFieldsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Theme.margin),
        ])
//        titleView.setContentHuggingPriority(.defaultLow, for: .vertical)
    }
    
    // MARK: Configure cell
    
    public func configure(number: Int, isExpanded: Bool) {
        titleLabel.text = "\(ordinalTitle(number))"
        self.isExpanded = isExpanded
        cellNumber = number
        setExpanded()
    }
}
