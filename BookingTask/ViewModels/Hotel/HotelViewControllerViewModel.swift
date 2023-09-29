//
//  HotelViewControllerViewModel.swift
//  BookingTask
//
//  Created by Sergei on 17.09.2023.
//

import Foundation

protocol HotelViewControllerViewModelDelegate: AnyObject {
    func didLoadHotelData()
}

final class HotelViewControllerViewModel {
    weak var delegate: HotelViewControllerViewModelDelegate?
    
    public var hotelData: Hotel?
    
    func fetchHotelData() {
        NetworkService.shared.execute(
            .hotelRequest,
            expecting: Hotel.self
        ) { [weak self] result in
            switch result {
                case .success(let hotelData):
                    self?.hotelData = hotelData
                    
                    DispatchQueue.main.async {
                        self?.delegate?.didLoadHotelData()
                    }
                case .failure(let error):
                    print(String(describing: error))
            }
        }
    }
}
