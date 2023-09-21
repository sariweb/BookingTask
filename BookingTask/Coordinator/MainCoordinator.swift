//
//  MainCoordinator.swift
//  BookingTask
//
//  Created by Sergei on 21.09.2023.
//

import UIKit

final class MainCoordinator: Coordinator {
    var navigationController: UINavigationController?
    
    func eventOccured(with event: Event, title: String? = nil) {
        switch event {
            case .hotel:
                let vc = HotelViewController()
                if let title = title {
                    vc.title = title
                }
                vc.coordinator = self
                navigationController?.setViewControllers([vc], animated: false)
            case .room:
                let vc = RoomViewController()
                if let title = title {
                    vc.title = title
                }
                vc.coordinator = self
                navigationController?.pushViewController(vc, animated: true)
            case .booking:
                let vc = BookingViewController()
                if let title = title {
                    vc.title = title
                }
                vc.coordinator = self
                navigationController?.pushViewController(vc, animated: true)
            case .result:
                let vc = ResultViewController()
                if let title = title {
                    vc.title = title
                }
                vc.coordinator = self
                navigationController?.pushViewController(vc, animated: true)
            case .home:
                let vc = HotelViewController()
                if let title = title {
                    vc.title = title
                }
                vc.coordinator = self
                navigationController?.setViewControllers([vc], animated: true)
        }
    }
}
