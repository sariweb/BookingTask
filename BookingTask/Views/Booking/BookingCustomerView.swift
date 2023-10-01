//
//  BookingCustomerView.swift
//  BookingTask
//
//  Created by Sergei on 30.09.2023.
//

import UIKit

final class BookingCustomerView: UIView {
    
    private var customerInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.titleFont
        label.textColor = .label
        label.text = "Информация о покупателе"
        
        return label
    }()
    
    private var phoneTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Номер"
        textField.backgroundColor = Theme.wrapperViewColor
        textField.layer.cornerRadius = 10
        textField.paddingLeft(inset: Theme.margin)
        
        return textField
    }()
    
    private var emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Почта"
        textField.backgroundColor = Theme.wrapperViewColor
        textField.layer.cornerRadius = 10
        textField.paddingLeft(inset: Theme.margin)
        
        return textField
    }()
    
    private var customerDescLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.smallDescriptionFont
        label.numberOfLines = 0
        label.textColor = Theme.descriptionColor
        label.text = "Эти данные никому не передаются. После оплаты мы вышлем чек на указанный вами номер и почту."
        
        return label
    }()
    
    private let phoneMask = "+7 (***) ***-**-**"
    private(set) var inputPhoneText = ""
    private(set) var inputEmailText = ""

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 12
        backgroundColor = .white
        
        addSubview(customerInfoLabel)
        addSubview(phoneTextField)
        addSubview(emailTextField)
        addSubview(customerDescLabel)
        
        phoneTextField.delegate = self
        phoneTextField.keyboardType = .numberPad
        emailTextField.delegate = self

        addConstraints()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        addGestureRecognizer(tapGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            customerInfoLabel.topAnchor.constraint(equalTo: topAnchor, constant: Theme.margin),
            customerInfoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Theme.margin),
            customerInfoLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Theme.margin),
            customerInfoLabel.heightAnchor.constraint(equalToConstant: 26),

            phoneTextField.topAnchor.constraint(equalTo: customerInfoLabel.bottomAnchor, constant: 20),
            phoneTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Theme.margin),
            phoneTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Theme.margin),
            phoneTextField.heightAnchor.constraint(equalToConstant: 52),
            
            emailTextField.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 8),
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Theme.margin),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Theme.margin),
            emailTextField.heightAnchor.constraint(equalToConstant: 52),
            
            customerDescLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 8),
            customerDescLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Theme.margin),
            customerDescLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Theme.margin),
            customerDescLabel.heightAnchor.constraint(equalToConstant: 34),
            
            heightAnchor.constraint(greaterThanOrEqualToConstant: 232),
        ])
    }
    
    @objc private func hideKeyboard() {
        endEditing(true)
    }
    
    private func setPosition(for textField: UITextField, offset: Int) {
        DispatchQueue.main.async {
            if let newPosition = textField.position(from: textField.beginningOfDocument, offset: offset) {
                
                textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
            }
        }
    }
    
    private func showErrorInTextField(_ textField: UITextField) {
        textField.layer.backgroundColor = Theme.errorTextFieldColor.cgColor
    }
    
    private func resetTextField(_ textField: UITextField) {
        textField.layer.backgroundColor = Theme.wrapperViewColor.cgColor
    }
}

extension BookingCustomerView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,    replacementString string:  String) -> Bool {
        // If Delete button click
        let char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        
        if textField == phoneTextField {
            var result = Array(phoneMask)

            if isBackSpace == -92 {
                if inputPhoneText.count > 0 {
                    inputPhoneText.removeLast()
                }
            } else {
                if inputPhoneText.count == 0, string != "9" {
                    return false
                }
                if inputPhoneText.count < 10 {
                    inputPhoneText += string
                }
            }
            
            var offset = 4
            
            for digit in inputPhoneText {
                if let index = result.firstIndex(of: "*") {
                    result[index] = digit
                    offset = Int(index)
                }
            }

            textField.text = result.map { String($0) }.joined()
            if inputPhoneText.count > 0 {
                offset += 1
            }
            setPosition(for: textField, offset: offset)
        } else if textField == emailTextField {
            if isBackSpace == -92 {
                if inputEmailText.count > 0 {
                    inputEmailText.removeLast()
                }
            } else {
                inputEmailText += string
            }
            
            textField.text = inputEmailText
        }
        
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == phoneTextField {
            resetTextField(textField)
            var offset = 4
            if let text = phoneTextField.text {
                if text == "" {
                    textField.text = phoneMask
                } else {
                    if let index = Array(text).firstIndex(of: "*") {
                        offset = Int(index)
                    } else {
                        offset = text.count
                    }
                }
                setPosition(for: textField, offset: offset)
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            if textField == phoneTextField {
                if text.firstIndex(of: "*") == nil {
                    resetTextField(textField)
                } else {
                    showErrorInTextField(textField)
                }
            } else if textField == emailTextField {
                if text.isBlank || !text.isEmail {
                    showErrorInTextField(textField)
                } else {
                    resetTextField(textField)
                }
            }
        }
        
        textField.resignFirstResponder()
    }
    
    // For pressing return on the keyboard to dismiss keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        for textField in self.subviews where textField is UITextField {
            textField.resignFirstResponder()
        }
        return true
    }
}
