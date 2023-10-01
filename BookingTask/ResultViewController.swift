//
//  ResultViewController.swift
//  BookingTask
//
//  Created by Sergei on 21.09.2023.
//

import UIKit

class ResultViewController: UIViewController, Coordinating {
    var coordinator: Coordinator?
    
    private var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "Party Popper")
        view.contentMode = .scaleAspectFill
        
        return view
    }()
    
    private var imageViewView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Theme.wrapperViewColor
        view.layer.cornerRadius = 47
        
        return view
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.titleFont
        label.textColor = .label
        label.textAlignment = .center
        label.text = "Ваш заказ принят в работу"
        
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.descriptionFont
        label.textColor = Theme.descriptionColor
        label.numberOfLines = 0
        label.textAlignment = .center
        
        return label
    }()
    
    private var transitionButtonView: TransitionButtonView = {
        let view = TransitionButtonView()
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        imageViewView.addSubview(imageView)
        
        view.addSubview(imageViewView)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(transitionButtonView)
        
        transitionButtonView.buttonTitle = "Супер!"
        transitionButtonView.delegate = self

        let number = Int.random(in: 0...100000)
        descriptionLabel.text = "Подтверждение заказа №\(number) может занять некоторое время (от 1 часа до суток). Как только мы получим ответ от туроператора, вам на почту придет уведомление."
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        addConstraints()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            imageViewView.topAnchor.constraint(lessThanOrEqualTo: view.topAnchor, constant: 223),
            imageViewView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageViewView.widthAnchor.constraint(equalToConstant: 94),
            imageViewView.heightAnchor.constraint(equalToConstant: 94),
            
            imageView.centerXAnchor.constraint(equalTo: imageViewView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: imageViewView.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 44),
            imageView.heightAnchor.constraint(equalToConstant: 44),
            
            titleLabel.topAnchor.constraint(equalTo: imageViewView.bottomAnchor, constant: 32),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 26),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            transitionButtonView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Theme.margin),
            transitionButtonView.bottomAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor, constant: -28),
            transitionButtonView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Theme.margin),
        ])
    }

}

extension ResultViewController: TransitionButtonViewDelegate {
    func didTapButton() {
        coordinator?.eventOccured(with: .home, title: "Отель")
    }
}
