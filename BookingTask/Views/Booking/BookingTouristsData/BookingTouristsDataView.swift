//
//  BookingTouristsDataView.swift
//  BookingTask
//
//  Created by Sergei on 04.10.2023.
//

import UIKit

protocol BookingTouristsDataViewDelegate: AnyObject {
    func didChangeTouristsHeight(_ height: CGFloat)
}

final class BookingTouristsDataView: UIView {
    weak var delegate: BookingTouristsDataViewDelegate?
    
    private var viewModels: [BookingTouristsDataViewViewModel] = []
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()

    private var cellHeight: CGFloat = Theme.touristCellExpandedHeight
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 12
        
        // set up models
        viewModels = [
            BookingTouristsDataViewViewModel(),
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
        tableView.register(BookingTouristsDataViewTableFooter.self,
                           forHeaderFooterViewReuseIdentifier: BookingTouristsDataViewTableFooter.identifier)

        tableView.alwaysBounceVertical = false
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(greaterThanOrEqualTo: bottomAnchor),

            heightAnchor.constraint(greaterThanOrEqualToConstant: Theme.touristCellHeight),
        ])
    }
    
    private func heightForViewModel(_ viewModel: BookingTouristsDataViewViewModel) -> CGFloat {
        return viewModel.isExpanded ? Theme.touristCellExpandedHeight : Theme.touristCellHeight
    }
    
    private func heightForTable() -> CGFloat {
        let initialHeight: CGFloat = 0
        let tableHeight: CGFloat = viewModels.reduce(initialHeight) { partialResult, viewModel in
            partialResult + heightForViewModel(viewModel)
        }
        return tableHeight
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
        
        return heightForViewModel(viewModel)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: BookingTouristsDataViewTableFooter.identifier) as? BookingTouristsDataViewTableFooter else {
            return UITableViewHeaderFooterView()
        }
        footer.delegate = self
        
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return Theme.touristCellHeight
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if indexPath.row != 0 {
            return UITableViewCell.EditingStyle.delete
        }
        
        return .none
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if indexPath.row != 0 {
            tableView.beginUpdates()
            
            viewModels.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            tableView.endUpdates()
        }
        tableView.reloadData()
    }
}

extension BookingTouristsDataView: BookingTouristsDataViewExpandCellDelegate {
    func didTapButton(isExpanded: Bool, cellNumber: Int) {
        viewModels[cellNumber].isExpanded = !viewModels[cellNumber].isExpanded
        tableView.reloadData()
        
        delegate?.didChangeTouristsHeight(heightForTable())
    }
}

extension BookingTouristsDataView: BookingTouristsDataViewTableFooterDelegate {
    func didTapAddTourist() {
        viewModels.append(BookingTouristsDataViewViewModel())
        tableView.reloadData()
        
        delegate?.didChangeTouristsHeight(heightForTable())
    }
}
