//
//  RoomViewController.swift
//  BookingTask
//
//  Created by Sergei on 18.09.2023.
//

import UIKit

class RoomViewController: UIViewController {
    private let roomView = RoomView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(roomView)
        view.backgroundColor = .white
        
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
