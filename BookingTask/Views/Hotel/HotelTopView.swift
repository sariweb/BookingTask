//
//  HotelTopView.swift
//  BookingTask
//
//  Created by Sergei on 15.09.2023.
//

import UIKit

class HotelTopView: UIView {
    public var topData: HotelTopViewViewModel? {
        didSet {
            guard let topData else { return }
            
            hotelInfoView.rating = "\(topData.rating) \(topData.ratingName)"
            hotelInfoView.title = topData.name
            hotelInfoView.address =  topData.adress
            
            priceView.price = "от \(topData.minimalPrice) ₽" 
            priceView.priceDesc = topData.priceForIt
            
            imageSliderView.imageUrls = topData.imageUrls
        }
    }
    
    private var imageSliderView: ImageSliderView = {
        let view = ImageSliderView()
        
        return view
    }()
    
    private var hotelInfoView: HotelInfoView = {
        let view = HotelInfoView()
        
        return view
    }()

    private var priceView: PriceView = {
        let view = PriceView()
        
        return view
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = Theme.margin
        clipsToBounds = true
        backgroundColor = .white

        addSubview(imageSliderView)
        addSubview(hotelInfoView)
        addSubview(priceView)
        
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            imageSliderView.topAnchor.constraint(equalTo: topAnchor),
            imageSliderView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Theme.margin),
            imageSliderView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Theme.margin),

            hotelInfoView.topAnchor.constraint(equalTo: imageSliderView.bottomAnchor),
            hotelInfoView.leadingAnchor.constraint(equalTo: leadingAnchor),
            hotelInfoView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            priceView.topAnchor.constraint(equalTo: hotelInfoView.bottomAnchor),
            priceView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Theme.margin),
            priceView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Theme.margin),
            priceView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -Theme.margin),
        ])
    }
}
