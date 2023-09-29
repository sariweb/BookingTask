//
//  RoomViewViewModel.swift
//  BookingTask
//
//  Created by Sergei on 18.09.2023.
//

import UIKit

protocol RoomViewViewModelDelegate: AnyObject {
    func didLoadRoomData()
    func didTapButton(with id: Int)
}

final class RoomViewViewModel: NSObject {
    weak var delegate: RoomViewViewModelDelegate?
    
    public var rooms: [Room] = []
    
    func fetchRoomData() {
        NetworkService.shared.execute(
            .roomRequest,
            expecting: Rooms.self
        ) { [weak self] result in
            switch result {
                case .success(let rooms):
                    self?.rooms = rooms.rooms
                    
                    DispatchQueue.main.async {
                        self?.delegate?.didLoadRoomData()
                    }
                case .failure(let error):
                    print(String(describing: error))
            }
        }
    }
}

// MARK: - TableView Data source

extension RoomViewViewModel: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: RoomTableViewCell.identifier,
            for: indexPath) as? RoomTableViewCell else { return UITableViewCell() }
        
        let room = rooms[indexPath.row]
        cell.configure(room: room)
        cell.delegate = self

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rooms.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 600
    }
}

extension RoomViewViewModel: RoomTableViewCellDelegate {
    func didTapButton(with id: Int) {
        delegate?.didTapButton(with: id)
    }
}
