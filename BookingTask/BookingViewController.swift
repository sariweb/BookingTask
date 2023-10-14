//
//  BookingViewController.swift
//  BookingTask
//
//  Created by Sergei on 19.09.2023.
//

import UIKit

class BookingViewController: UIViewController, Coordinating {
    var coordinator: Coordinator?

    private let bookingView = BookingView()
    
    private var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.addSubview(bookingView)
        view.addSubview(scrollView)
        view.backgroundColor = .white
        
        bookingView.delegate = self
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        addConstraints()
    }
    
    var bookingHeightConstraint: NSLayoutConstraint?

    private func addConstraints() {
        bookingHeightConstraint = bookingView.heightAnchor.constraint(equalToConstant: 1050 + bookingView.touristsHeight)
        NSLayoutConstraint.activate([
            bookingView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            bookingView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            bookingView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            bookingView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            bookingView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            bookingHeightConstraint!,
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

extension BookingViewController: BookingViewDelegate {
    func didTapButton() {
        coordinator?.eventOccured(with: .result, title: "Заказ оплачен")
    }
    
    func updateUI() {
        if bookingHeightConstraint != nil {
            NSLayoutConstraint.deactivate([
                bookingHeightConstraint!,
            ])
            
            bookingHeightConstraint = bookingView.heightAnchor.constraint(equalToConstant: 1050 + bookingView.touristsHeight)
            
            NSLayoutConstraint.activate([
                bookingHeightConstraint!,
            ])
            
        }
        
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
}
