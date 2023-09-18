//
//  HotelAboutViewViewModel.swift
//  BookingTask
//
//  Created by Sergei on 16.09.2023.
//

import UIKit

protocol HotelAboutViewViewModelDelegate: AnyObject {
    func didLoadOptions()
}

final class HotelAboutViewViewModel: NSObject {
    
    private var optionViewModels: [OptionCellViewModel] = []
    
    weak var delegate: HotelAboutViewViewModelDelegate?
    
    public func loadOptions() {
        optionViewModels = [
            .init(option: "Удобства", optionDesc: "Самое необходимое", optionIcon: "emoji-happy"),
            .init(option: "Что включено", optionDesc: "Самое необходимое", optionIcon: "tick-square"),
            .init(option: "Удобства", optionDesc: "Самое необходимое", optionIcon: "close-square"),
        ]
        
        delegate?.didLoadOptions()
    }
}

// MARK: - TableView Data source

extension HotelAboutViewViewModel: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: OptionsTableViewCell.identifier,
            for: indexPath) as? OptionsTableViewCell else { return UITableViewCell() }
        
        let viewModel = optionViewModels[indexPath.row]
        cell.configure(viewModel: viewModel)

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionViewModels.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
