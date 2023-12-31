//
//  HotelViewController.swift
//  BookingTask
//
//  Created by Sergei on 12.09.2023.
//

import UIKit

class HotelViewController: UIViewController, Coordinating {
    var coordinator: Coordinator?
    
    private let topView = HotelTopView()
    private var aboutView = HotelAboutView()
    private var transitionButtonView = TransitionButtonView()
    
    private let viewModel = HotelViewControllerViewModel()
    
    private var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.wrapperViewColor
        title = "Отель"
        
        viewModel.fetchHotelData()
        viewModel.delegate = self
        
        setupView()
        addConstraints()
    }
    
    private func setupView() {
        contentView.addSubview(topView)
        contentView.addSubview(aboutView)
        contentView.addSubview(bottomView)
        bottomView.addSubview(transitionButtonView)
        transitionButtonView.delegate = self
        scrollView.addSubview(contentView)
        view.addSubview(scrollView)
        transitionButtonView.buttonTitle = "К выбору номера"
    }
    
    private func addConstraints() {
        let heightConstraint = contentView.heightAnchor.constraint(equalToConstant: 985)
            heightConstraint.priority = UILayoutPriority(250)
        
        NSLayoutConstraint.activate([
//             top view
            topView.topAnchor.constraint(equalTo: contentView.topAnchor),
            topView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
//             about view
            aboutView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 8),
            aboutView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            aboutView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            aboutView.heightAnchor.constraint(equalToConstant: 428),
            
//             bottom view
            bottomView.topAnchor.constraint(equalTo: aboutView.bottomAnchor, constant: 8),
            bottomView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 88),

            transitionButtonView.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 12),
            transitionButtonView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: Theme.margin),
            transitionButtonView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -Theme.margin),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            heightConstraint,
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}


extension HotelViewController: HotelViewControllerViewModelDelegate {
    func didLoadHotelData() {
        guard let hotelData = viewModel.hotelData
        else { return }
        topView.topData = HotelTopViewViewModel(
            name: hotelData.name,
            adress: hotelData.adress,
            minimalPrice: hotelData.minimalPrice,
            priceForIt: hotelData.priceForIt,
            rating: hotelData.rating,
            ratingName: hotelData.ratingName,
            imageUrls: hotelData.imageUrls
        )
        
        aboutView.configure(with: hotelData.aboutTheHotel)
    }
}

extension HotelViewController: TransitionButtonViewDelegate {
    func didTapButton() {
        coordinator?.eventOccured(with: .room, title: viewModel.hotelData?.name)
    }
}
