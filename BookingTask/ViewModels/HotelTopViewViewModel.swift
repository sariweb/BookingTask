//
//  HotelTopViewViewModel.swift
//  BookingTask
//
//  Created by Sergei on 17.09.2023.
//

import Foundation

final class HotelTopViewViewModel: NSObject {
    let name, adress: String
    let minimalPrice: Int
    let priceForIt: String
    let rating: Int
    let ratingName: String
    let imageUrls: [String]
    
    init(name: String, adress: String, minimalPrice: Int, priceForIt: String, rating: Int, ratingName: String, imageUrls: [String]) {
        self.name = name
        self.adress = adress
        self.minimalPrice = minimalPrice
        self.priceForIt = priceForIt
        self.rating = rating
        self.ratingName = ratingName
        self.imageUrls = imageUrls
    }
}
