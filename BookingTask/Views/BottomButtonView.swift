//
//  HotelBottomView.swift
//  BookingTask
//
//  Created by Sergei on 15.09.2023.
//

import UIKit

class BottomButtonView: UIView {
    
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
        
        return button
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        
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
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Theme.margin),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Theme.margin),
            button.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
}
