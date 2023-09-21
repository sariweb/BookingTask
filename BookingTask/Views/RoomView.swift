//
//  RoomView.swift
//  BookingTask
//
//  Created by Sergei on 18.09.2023.
//

import UIKit

protocol RoomViewDelegate: AnyObject {
    func didTapButton(with id: Int)
}

class RoomView: UIView {
    private let viewModel = RoomViewViewModel()
    
    weak var delegate: RoomViewDelegate?
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(RoomTableViewCell.self,
                      forCellReuseIdentifier: RoomTableViewCell.identifier)
        
        view.separatorStyle = .none
        
        return view
    }()

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false

        addSubview(tableView)
        setupTableView()
        
        viewModel.delegate = self
        viewModel.fetchRoomData()

        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableView() {
        tableView.dataSource = viewModel
        tableView.delegate = viewModel
        tableView.tableFooterView = UIView()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

}

extension RoomView: RoomViewViewModelDelegate {
    func didTapButton(with id: Int) {
        delegate?.didTapButton(with: id)
    }
    
    func didLoadRoomData() {
        tableView.reloadData()
    }
}
