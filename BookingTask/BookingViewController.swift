//
//  BookingViewController.swift
//  BookingTask
//
//  Created by Sergei on 19.09.2023.
//

import UIKit

class BookingViewController: UIViewController {

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
        
        addConstraints()
    }
    
    private func addConstraints() {
        let heightConstraint = bookingView.heightAnchor.constraint(equalToConstant: 1500)
            heightConstraint.priority = UILayoutPriority(250)
        
        NSLayoutConstraint.activate([
            bookingView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            bookingView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            bookingView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            bookingView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            bookingView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            heightConstraint,
            
            scrollView.topAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}
