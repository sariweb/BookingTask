//
//  BookingViewViewModel.swift
//  BookingTask
//
//  Created by Sergei on 19.09.2023.
//

import Foundation

protocol BookingViewViewModelDelegate: AnyObject {
    func didLoadBookingData()
}

final class BookingViewViewModel: NSObject {
    weak var delegate: BookingViewViewModelDelegate?
    
    private(set) var bookingLoadedData: Booking?
    
    func fetchBookingData() {
        NetworkService.shared.execute(
            .bookingRequest,
            expecting: Booking.self
        ) { [weak self] result in
            switch result {
                case .success(let bookingData):
                    self?.bookingLoadedData = bookingData
                    
                    DispatchQueue.main.async {
                        self?.delegate?.didLoadBookingData()
                    }
                case .failure(let error):
                    print(String(describing: error))
            }
        }
    }
}
