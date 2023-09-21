//
//  RoomViewController.swift
//  BookingTask
//
//  Created by Sergei on 18.09.2023.
//

import UIKit

class RoomViewController: UIViewController, Coordinating {
    var coordinator: Coordinator?
    
    private let roomView = RoomView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(roomView)
        roomView.delegate = self
        view.backgroundColor = .white
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        addConstraints()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            roomView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            roomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            roomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            roomView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}

extension RoomViewController: RoomViewDelegate {
    func didTapButton(with id: Int) {
        coordinator?.eventOccured(with: .booking, title: "Бронирование")
    }
}
