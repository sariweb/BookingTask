//
//  HotelAboutView.swift
//  BookingTask
//
//  Created by Sergei on 15.09.2023.
//

import UIKit



class HotelAboutView: UIView {
    
    private let viewModel = HotelAboutViewViewModel()
    
    private let aboutLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Об отеле"
        label.font = Theme.titleFont
        label.textColor = .label
        
        return label
    }()
    
    private let featuresView: TagLabelsView = {
        let view = TagLabelsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = Theme.descriptionFont
        label.textColor = .label
        
        return label
    }()
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(OptionsTableViewCell.self,
                      forCellReuseIdentifier: OptionsTableViewCell.identifier)
        
        view.separatorInset = .init(top: 0, left: 53, bottom: 0, right: Theme.margin)
        
        return view
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupView()
        setupViews()
        addConstraints()
        viewModel.delegate = self
        viewModel.loadOptions()
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = Theme.margin
        clipsToBounds = true
        backgroundColor = .white
    }
    
    public func configure(with aboutData: AboutTheHotel) {
        infoLabel.text = aboutData.description
        featuresView.tagNames = aboutData.peculiarities
    }
    
    private func setupViews() {
        addSubview(aboutLabel)
        addSubview(featuresView)
        addSubview(infoLabel)
        addSubview(tableView)
    }
    
    private func setupTableView() {
        tableView.dataSource = viewModel
        tableView.delegate = viewModel
        tableView.layer.cornerRadius = Theme.margin
        tableView.tableFooterView = UIView()
        tableView.alwaysBounceVertical = false
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            aboutLabel.topAnchor.constraint(equalTo: topAnchor, constant: Theme.margin),
            aboutLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Theme.margin),
            aboutLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Theme.margin),
            aboutLabel.heightAnchor.constraint(equalToConstant: 26),

            featuresView.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor, constant: Theme.margin),
            featuresView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Theme.margin),
            featuresView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Theme.margin),


            infoLabel.topAnchor.constraint(equalTo: featuresView.bottomAnchor, constant: Theme.margin),
            infoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Theme.margin),
            infoLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Theme.margin),
            infoLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -2 * Theme.margin),

            tableView.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: Theme.margin),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Theme.margin),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Theme.margin),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Theme.margin),
            tableView.heightAnchor.constraint(equalToConstant: 184),
        ])
    }
}

extension HotelAboutView: HotelAboutViewViewModelDelegate {
    func didLoadOptions() {
        tableView.reloadData()
    }
}
