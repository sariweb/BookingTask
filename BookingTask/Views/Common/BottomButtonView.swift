//
//  HotelBottomView.swift
//  BookingTask
//
//  Created by Sergei on 15.09.2023.
//

import UIKit

protocol BottomButtonViewDelegate: AnyObject {
    func didTapButton()
}

class BottomButtonView: UIView {
    weak var delegate: BottomButtonViewDelegate?
    
    public var buttonTitle: String? {
        didSet {
            guard let buttonTitle else { return }
            button.setTitle(buttonTitle, for: .normal)
        }
    }
    
    private var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Theme.buttonColor
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    
        return button
    }()
    
    @objc
    func didTapButton() {
        delegate?.didTapButton()
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        
        addSubview(button)
        
        addConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Theme.margin),
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Theme.margin),
            button.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
}