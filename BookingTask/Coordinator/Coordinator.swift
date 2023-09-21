//
//  Coordinator.swift
//  BookingTask
//
//  Created by Sergei on 21.09.2023.
//

import UIKit

enum Event {
    case hotel
    case room
    case booking
    case result
    case home
}

protocol Coordinator {
    var navigationController: UINavigationController? { get set }
    func eventOccured(with event: Event, title: String?)
}

protocol Coordinating {
    var coordinator: Coordinator? { get set }
}
