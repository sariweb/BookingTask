//
//  BookingInfoView.swift
//  BookingTask
//
//  Created by Sergei on 30.09.2023.
//

import UIKit

final class BookingInfoView: UIView {
    
    public var departure: String? {
        didSet {
            departureDataLabel.text = departure
        }
    }

    public var arrival: String? {
        didSet {
            arrivalDataLabel.text = arrival
        }
    }

    public var dates: String? {
        didSet {
            datesDataLabel.text = dates
        }
    }
    
    public var nightsNumber: Int? {
        didSet {
            if nightsNumber != nil {
                nightsNumberDataLabel.text = "\(nightsNumber!) ночей"
            }
        }
    }
    
    public var hotelName: String? {
        didSet {
            hotelNameDataLabel.text = hotelName
        }
    }
    
    public var room: String? {
        didSet {
            roomDataLabel.text = room
        }
    }
    
    public var nutrition: String? {
        didSet {
            nutritionDataLabel.text = nutrition
        }
    }
    
    private var departureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.descriptionFont
        label.textColor = Theme.descriptionColor
        label.text = "Вылет из"
        
        return label
    }()
    
    private var departureDataLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.descriptionFont
        label.textColor = .label
        
        return label
    }()
    
    private var arrivalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.descriptionFont
        label.textColor = Theme.descriptionColor
        label.text = "Страна, город"
        
        return label
    }()
    
    private var arrivalDataLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.descriptionFont
        label.textColor = .label
        
        return label
    }()
    
    private var datesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.descriptionFont
        label.textColor = Theme.descriptionColor
        label.text = "Даты"
        
        return label
    }()
    
    private var datesDataLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.descriptionFont
        label.textColor = .label
        
        return label
    }()
    
    private var nightsNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.descriptionFont
        label.textColor = Theme.descriptionColor
        label.text = "Кол-во ночей"
        
        return label
    }()
    
    private var nightsNumberDataLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.descriptionFont
        label.textColor = .label
        
        return label
    }()
    
    private var hotelNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.descriptionFont
        label.textColor = Theme.descriptionColor
        label.text = "Отель"
        
        return label
    }()
    
    private var hotelNameDataLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.descriptionFont
        label.textColor = .label
        label.numberOfLines = 0
        
        return label
    }()
    
    private var roomLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.descriptionFont
        label.textColor = Theme.descriptionColor
        label.text = "Номер"
        
        return label
    }()
    
    private var roomDataLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.descriptionFont
        label.textColor = .label
        label.numberOfLines = 0
        
        return label
    }()
    
    private var nutritionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.descriptionFont
        label.textColor = Theme.descriptionColor
        label.text = "Питание"
        
        return label
    }()
    
    private var nutritionDataLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.descriptionFont
        label.textColor = .label
        
        return label
    }()

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 12
        backgroundColor = .white
        
        addSubview(departureLabel)
        addSubview(arrivalLabel)
        addSubview(datesLabel)
        addSubview(nightsNumberLabel)
        addSubview(hotelNameLabel)
        addSubview(roomLabel)
        addSubview(nutritionLabel)
        
        addSubview(departureDataLabel)
        addSubview(arrivalDataLabel)
        addSubview(datesDataLabel)
        addSubview(nightsNumberDataLabel)
        addSubview(hotelNameDataLabel)
        addSubview(roomDataLabel)
        addSubview(nutritionDataLabel)

        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        
        NSLayoutConstraint.activate([
            departureLabel.topAnchor.constraint(equalTo: topAnchor, constant: Theme.margin),
            departureLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Theme.margin),
            
            departureDataLabel.topAnchor.constraint(equalTo: topAnchor, constant: Theme.margin),
            departureDataLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 156),
            departureDataLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Theme.margin),
            
            arrivalLabel.topAnchor.constraint(equalTo: departureDataLabel.bottomAnchor, constant: Theme.margin),
            arrivalLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Theme.margin),
            
            arrivalDataLabel.topAnchor.constraint(equalTo: arrivalLabel.topAnchor),
            arrivalDataLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 156),
            arrivalDataLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Theme.margin),
            
            datesLabel.topAnchor.constraint(equalTo: arrivalDataLabel.bottomAnchor, constant: Theme.margin),
            datesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Theme.margin),
            
            datesDataLabel.topAnchor.constraint(equalTo: datesLabel.topAnchor),
            datesDataLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 156),
            datesDataLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Theme.margin),
            
            nightsNumberLabel.topAnchor.constraint(equalTo: datesDataLabel.bottomAnchor, constant: Theme.margin),
            nightsNumberLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Theme.margin),
            
            nightsNumberDataLabel.topAnchor.constraint(equalTo: nightsNumberLabel.topAnchor),
            nightsNumberDataLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 156),
            nightsNumberDataLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Theme.margin),
            
            hotelNameLabel.topAnchor.constraint(equalTo: nightsNumberDataLabel.bottomAnchor, constant: Theme.margin),
            hotelNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Theme.margin),
            
            hotelNameDataLabel.topAnchor.constraint(equalTo: hotelNameLabel.topAnchor),
            hotelNameDataLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 156),
            hotelNameDataLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Theme.margin),
            
            roomLabel.topAnchor.constraint(equalTo: hotelNameDataLabel.bottomAnchor, constant: Theme.margin),
            roomLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Theme.margin),
            
            roomDataLabel.topAnchor.constraint(equalTo: roomLabel.topAnchor),
            roomDataLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 156),
            roomDataLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Theme.margin),

            nutritionLabel.topAnchor.constraint(equalTo: roomDataLabel.bottomAnchor, constant: Theme.margin),
            nutritionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Theme.margin),
            
            nutritionDataLabel.topAnchor.constraint(equalTo: nutritionLabel.topAnchor),
            nutritionDataLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 156),
            nutritionDataLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Theme.margin),
            
            heightAnchor.constraint(greaterThanOrEqualToConstant: 304),
        ])
    }
}

