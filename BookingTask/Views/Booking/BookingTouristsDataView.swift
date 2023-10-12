//
//  BookingTouristsDataView.swift
//  BookingTask
//
//  Created by Sergei on 04.10.2023.
//

import UIKit

final class BookingTouristsDataViewViewModel {
    let title: String
    var isExpanded: Bool = true
    
    init(title: String, isExpanded: Bool = true) {
        self.title = title
        self.isExpanded = isExpanded
    }
}

final class BookingTouristsDataView: UIView {
    
    private var viewModels: [BookingTouristsDataViewViewModel] = []
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()

    private var cellHeight: CGFloat = 430
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 12
        
        // set up models
        viewModels = [
            BookingTouristsDataViewViewModel(title: "Tourist 1"),
            BookingTouristsDataViewViewModel(title: "Tourist 2"),
        ]
        
        addSubview(tableView)
        
        setupTableView()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(BookingTouristsDataViewExpandCell.self,
                           forCellReuseIdentifier: BookingTouristsDataViewExpandCell.identifier)
        tableView.tableFooterView = UIView()
//        tableView.separatorStyle = .none
        tableView.alwaysBounceVertical = false
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),

            heightAnchor.constraint(equalToConstant: 430),
        ])
    }
}

// MARK: - TableView Data source

extension BookingTouristsDataView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: BookingTouristsDataViewExpandCell.identifier,
            for: indexPath) as? BookingTouristsDataViewExpandCell else { return UITableViewCell() }
        cell.delegate = self
        cell.configure(number: indexPath.row, isExpanded: viewModels[indexPath.row].isExpanded)
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let viewModel = viewModels[indexPath.row]
        let cellHeight: CGFloat = viewModel.isExpanded ? 430 : 64
        return cellHeight
    }
}

extension BookingTouristsDataView: BookingTouristsDataViewExpandCellDelegate {
    func didTapButton(isExpanded: Bool, cellNumber: Int) {
        viewModels[cellNumber].isExpanded = !viewModels[cellNumber].isExpanded
        tableView.reloadData()
    }
}
