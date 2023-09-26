//
//  BookingView.swift
//  BookingTask
//
//  Created by Sergei on 19.09.2023.
//

import UIKit

protocol BookingViewDelegate: AnyObject {
    func didTapButton()
}

class BookingView: UIView {
    private let viewModel = BookingViewViewModel()
    
    weak var delegate: BookingViewDelegate?
    
    static let viewCornerRadius: CGFloat = 12
    
    private var paymentSum = 0
        
    private var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Theme.wrapperViewColor
        
        return view
    }()
    
    private var hotelView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = BookingView.viewCornerRadius
        view.backgroundColor = .white
        
        return view
    }()
    
    private var starsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.backgroundColor = Theme.starsViewColor
        return view
    }()
    
    private var starsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.starsFont
        label.textColor = Theme.starsLabelColor
        
        return label
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.titleFont
        label.textColor = .label
        label.numberOfLines = 0
        
        return label
    }()
    
    private var addressButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = Theme.addressFont
        button.titleLabel?.textColor = Theme.textButtonColor
        button.titleLabel?.textAlignment = .left
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -24, bottom: 0, right: 0)

        return button
    }()
    
    private var infoLabelStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 8
        view.distribution = .fill
        view.backgroundColor = .white
        return view
    }()
    
    // MARK: - Booking view
    
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
    
    private var bookingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = BookingView.viewCornerRadius
        view.backgroundColor = .white
        
        return view
    }()

    // MARK: - Customer view
    
    private var customerInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.titleFont
        label.textColor = .label
        label.text = "Информация о покупателе"
        
        return label
    }()
    
    private var phoneTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Номер"
        textField.backgroundColor = Theme.wrapperViewColor
        textField.layer.cornerRadius = 10
        textField.paddingLeft(inset: Theme.margin)
        
        return textField
    }()
    
    private var emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Почта"
        textField.backgroundColor = Theme.wrapperViewColor
        textField.layer.cornerRadius = 10
        textField.paddingLeft(inset: Theme.margin)
        
        return textField
    }()
    
    private var customerDescLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.smallDescriptionFont
        label.numberOfLines = 0
        label.textColor = Theme.descriptionColor
        label.text = "Эти данные никому не передаются. После оплаты мы вышлем чек на указанный вами номер и почту."
        
        return label
    }()
    
    private var customerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = BookingView.viewCornerRadius
        view.backgroundColor = .white

        return view
    }()
    
    // MARK: - First Tourist view
    
    private var firstTouristInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.titleFont
        label.textColor = .label
        label.text = "Первый турист"
        
        return label
    }()
    
    private var firstTouristCollapseButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Theme.buttonBgColor
        button.titleLabel?.textColor = Theme.textButtonColor
        button.layer.cornerRadius = 6
        
        return button
    }()
    
    private var firstTouristTitleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()

    private var nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Имя"
        textField.backgroundColor = Theme.wrapperViewColor
        textField.layer.cornerRadius = 10
        textField.paddingLeft(inset: Theme.margin)
        
        return textField
    }()
    
    private var surnameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Фамилия"
        textField.backgroundColor = Theme.wrapperViewColor
        textField.layer.cornerRadius = 10
        textField.paddingLeft(inset: Theme.margin)
        
        return textField
    }()
    
    private var birthDateTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Дата рождения"
        textField.backgroundColor = Theme.wrapperViewColor
        textField.layer.cornerRadius = 10
        textField.paddingLeft(inset: Theme.margin)
        
        return textField
    }()
    
    private var citizenshipTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Гражданство"
        textField.backgroundColor = Theme.wrapperViewColor
        textField.layer.cornerRadius = 10
        textField.paddingLeft(inset: Theme.margin)
        
        return textField
    }()
    
    private var passportNumberTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Номер загранпаспорта"
        textField.backgroundColor = Theme.wrapperViewColor
        textField.layer.cornerRadius = 10
        textField.paddingLeft(inset: Theme.margin)
        
        return textField
    }()
    
    private var passportEspDateField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Срок действия загранпаспорта"
        textField.backgroundColor = Theme.wrapperViewColor
        textField.layer.cornerRadius = 10
        textField.paddingLeft(inset: Theme.margin)
        
        return textField
    }()
    
    private var firstTouristStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 8

        return view
    }()
    
    private var firstTouristView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = BookingView.viewCornerRadius
        view.backgroundColor = .white

        return view
    }()
    
    // MARK: - Second Tourist view
    
    private var secondTouristInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.titleFont
        label.textColor = .label
        label.text = "Второй турист"
        
        return label
    }()
    
    private var secondTouristCollapseButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Theme.buttonBgColor
        button.titleLabel?.textColor = Theme.textButtonColor
        button.layer.cornerRadius = 6
        
        return button
    }()
    
    private var secondTouristTitleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemCyan
        
        return view
    }()
    
    private var secondTouristView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = BookingView.viewCornerRadius
        view.backgroundColor = .white

        return view
    }()
    
    // MARK: - Add Tourist view
    
    private var addTouristInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.titleFont
        label.textColor = .label
        label.text = "Добавить туриста"
        
        return label
    }()
    
    private var addTouristCollapseButton: UIButton = {
        let button = UIButton()
        let configuration = UIImage.SymbolConfiguration(font: Theme.descriptionFont)
        let image = UIImage(systemName: "plus", withConfiguration: configuration)
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Theme.buttonColor
        button.tintColor = .white
        button.layer.cornerRadius = 6
        
        return button
    }()
    
    private var addTouristTitleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemCyan
        
        return view
    }()
    
    private var addTouristView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = BookingView.viewCornerRadius
        view.backgroundColor = .white

        return view
    }()
    
    // MARK: - Price view
    
    private var tourLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.descriptionFont
        label.textColor = Theme.descriptionColor
        label.text = "Тур"
        
        return label
    }()
    
    private var tourDataLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.descriptionFont
        label.textColor = .label
        
        return label
    }()
    
    private var fuelChargeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.descriptionFont
        label.textColor = Theme.descriptionColor
        label.text = "Топливный сбор"
        
        return label
    }()
    
    private var fuelChargeDataLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.descriptionFont
        label.textColor = .label
        
        return label
    }()
    
    private var serviceChargeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.descriptionFont
        label.textColor = Theme.descriptionColor
        label.text = "Сервисный сбор"
        
        return label
    }()
    
    private var serviceChargeDataLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.descriptionFont
        label.textColor = .label
        
        return label
    }()
    
    private var paymentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.descriptionFont
        label.textColor = Theme.descriptionColor
        label.text = "К оплате"
        
        return label
    }()
    
    private var paymentDataLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.paymentFont
        label.textColor = Theme.buttonColor
        
        return label
    }()
    
    private var priceView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = BookingView.viewCornerRadius
        view.backgroundColor = .white
        
        return view
    }()
    
    private var bottomView: BottomButtonView = {
        let view = BottomButtonView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let phoneMask = "+7 (***) ***-**-**"
    private var inputPhoneText = ""
    private var inputEmailText = ""

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        starsView.addSubview(starsLabel)
        
        infoLabelStackView.addArrangedSubview(titleLabel)
        infoLabelStackView.addArrangedSubview(addressButton)
        
        hotelView.addSubview(starsView)
        hotelView.addSubview(infoLabelStackView)
        
        bookingView.addSubview(departureLabel)
        bookingView.addSubview(arrivalLabel)
        bookingView.addSubview(datesLabel)
        bookingView.addSubview(nightsNumberLabel)
        bookingView.addSubview(hotelNameLabel)
        bookingView.addSubview(roomLabel)
        bookingView.addSubview(nutritionLabel)
        
        bookingView.addSubview(departureDataLabel)
        bookingView.addSubview(arrivalDataLabel)
        bookingView.addSubview(datesDataLabel)
        bookingView.addSubview(nightsNumberDataLabel)
        bookingView.addSubview(hotelNameDataLabel)
        bookingView.addSubview(roomDataLabel)
        bookingView.addSubview(nutritionDataLabel)
        
        customerView.addSubview(customerInfoLabel)
        customerView.addSubview(phoneTextField)
        customerView.addSubview(emailTextField)
        customerView.addSubview(customerDescLabel)
        
        phoneTextField.delegate = self
        phoneTextField.keyboardType = .numberPad
        emailTextField.delegate = self

        firstTouristStackView.addArrangedSubview(nameTextField)
        firstTouristStackView.addArrangedSubview(surnameTextField)
        firstTouristStackView.addArrangedSubview(birthDateTextField)
        firstTouristStackView.addArrangedSubview(citizenshipTextField)
        firstTouristStackView.addArrangedSubview(passportNumberTextField)
        firstTouristStackView.addArrangedSubview(passportEspDateField)
        
        firstTouristTitleView.addSubview(firstTouristInfoLabel)
        firstTouristTitleView.addSubview(firstTouristCollapseButton)
        firstTouristView.addSubview(firstTouristTitleView)
        firstTouristView.addSubview(firstTouristStackView)
        
        secondTouristTitleView.addSubview(secondTouristInfoLabel)
        secondTouristTitleView.addSubview(secondTouristCollapseButton)
        secondTouristView.addSubview(secondTouristTitleView)
        
        addTouristTitleView.addSubview(addTouristInfoLabel)
        addTouristTitleView.addSubview(addTouristCollapseButton)
        addTouristView.addSubview(addTouristTitleView)
        
        priceView.addSubview(tourLabel)
        priceView.addSubview(fuelChargeLabel)
        priceView.addSubview(serviceChargeLabel)
        priceView.addSubview(paymentLabel)
        priceView.addSubview(tourDataLabel)
        priceView.addSubview(fuelChargeDataLabel)
        priceView.addSubview(serviceChargeDataLabel)
        priceView.addSubview(paymentDataLabel)
        
        contentView.addSubview(hotelView)
        contentView.addSubview(bookingView)
        contentView.addSubview(customerView)
        contentView.addSubview(firstTouristView)
        contentView.addSubview(secondTouristView)
        contentView.addSubview(addTouristView)
        contentView.addSubview(priceView)
        contentView.addSubview(bottomView)
        
        bottomView.delegate = self
        
        addSubview(contentView)
        
        viewModel.delegate = self
        viewModel.fetchBookingData()

        addConstraints()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        addGestureRecognizer(tapGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            // MARK: - Hotel view constraints
            starsView.topAnchor.constraint(equalTo: hotelView.topAnchor, constant: Theme.margin),
            starsView.leadingAnchor.constraint(equalTo: hotelView.leadingAnchor, constant: Theme.margin),
            starsView.heightAnchor.constraint(equalToConstant: 29),
            
            starsLabel.topAnchor.constraint(equalTo: starsView.topAnchor, constant: 5),
            starsLabel.leadingAnchor.constraint(equalTo: starsView.leadingAnchor, constant: 10),
            starsLabel.bottomAnchor.constraint(equalTo: starsView.bottomAnchor, constant: -5),
            starsLabel.trailingAnchor.constraint(equalTo: starsView.trailingAnchor, constant: -10),
            
            infoLabelStackView.topAnchor.constraint(equalTo: starsView.bottomAnchor, constant: 8),
            infoLabelStackView.leadingAnchor.constraint(equalTo: hotelView.leadingAnchor, constant: Theme.margin),
            infoLabelStackView.trailingAnchor.constraint(equalTo: hotelView.trailingAnchor, constant: -Theme.margin),
            
            hotelView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            hotelView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            hotelView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            hotelView.heightAnchor.constraint(greaterThanOrEqualToConstant: 152),
            
            // MARK: - Booking view constraints
            departureLabel.topAnchor.constraint(equalTo: bookingView.topAnchor, constant: Theme.margin),
            departureLabel.leadingAnchor.constraint(equalTo: bookingView.leadingAnchor, constant: Theme.margin),
            
            departureDataLabel.topAnchor.constraint(equalTo: bookingView.topAnchor, constant: Theme.margin),
            departureDataLabel.leadingAnchor.constraint(equalTo: bookingView.leadingAnchor, constant: 156),
            departureDataLabel.trailingAnchor.constraint(equalTo: bookingView.trailingAnchor, constant: -Theme.margin),
            
            arrivalLabel.topAnchor.constraint(equalTo: departureDataLabel.bottomAnchor, constant: Theme.margin),
            arrivalLabel.leadingAnchor.constraint(equalTo: bookingView.leadingAnchor, constant: Theme.margin),
            
            arrivalDataLabel.topAnchor.constraint(equalTo: arrivalLabel.topAnchor),
            arrivalDataLabel.leadingAnchor.constraint(equalTo: bookingView.leadingAnchor, constant: 156),
            arrivalDataLabel.trailingAnchor.constraint(equalTo: bookingView.trailingAnchor, constant: -Theme.margin),
            
            datesLabel.topAnchor.constraint(equalTo: arrivalDataLabel.bottomAnchor, constant: Theme.margin),
            datesLabel.leadingAnchor.constraint(equalTo: bookingView.leadingAnchor, constant: Theme.margin),
            
            datesDataLabel.topAnchor.constraint(equalTo: datesLabel.topAnchor),
            datesDataLabel.leadingAnchor.constraint(equalTo: bookingView.leadingAnchor, constant: 156),
            datesDataLabel.trailingAnchor.constraint(equalTo: bookingView.trailingAnchor, constant: -Theme.margin),
            
            nightsNumberLabel.topAnchor.constraint(equalTo: datesDataLabel.bottomAnchor, constant: Theme.margin),
            nightsNumberLabel.leadingAnchor.constraint(equalTo: bookingView.leadingAnchor, constant: Theme.margin),
            
            nightsNumberDataLabel.topAnchor.constraint(equalTo: nightsNumberLabel.topAnchor),
            nightsNumberDataLabel.leadingAnchor.constraint(equalTo: bookingView.leadingAnchor, constant: 156),
            nightsNumberDataLabel.trailingAnchor.constraint(equalTo: bookingView.trailingAnchor, constant: -Theme.margin),
            
            hotelNameLabel.topAnchor.constraint(equalTo: nightsNumberDataLabel.bottomAnchor, constant: Theme.margin),
            hotelNameLabel.leadingAnchor.constraint(equalTo: bookingView.leadingAnchor, constant: Theme.margin),
            
            hotelNameDataLabel.topAnchor.constraint(equalTo: hotelNameLabel.topAnchor),
            hotelNameDataLabel.leadingAnchor.constraint(equalTo: bookingView.leadingAnchor, constant: 156),
            hotelNameDataLabel.trailingAnchor.constraint(equalTo: bookingView.trailingAnchor, constant: -Theme.margin),
            
            roomLabel.topAnchor.constraint(equalTo: hotelNameDataLabel.bottomAnchor, constant: Theme.margin),
            roomLabel.leadingAnchor.constraint(equalTo: bookingView.leadingAnchor, constant: Theme.margin),
            
            roomDataLabel.topAnchor.constraint(equalTo: roomLabel.topAnchor),
            roomDataLabel.leadingAnchor.constraint(equalTo: bookingView.leadingAnchor, constant: 156),
            roomDataLabel.trailingAnchor.constraint(equalTo: bookingView.trailingAnchor, constant: -Theme.margin),

            nutritionLabel.topAnchor.constraint(equalTo: roomDataLabel.bottomAnchor, constant: Theme.margin),
            nutritionLabel.leadingAnchor.constraint(equalTo: bookingView.leadingAnchor, constant: Theme.margin),
            
            nutritionDataLabel.topAnchor.constraint(equalTo: nutritionLabel.topAnchor),
            nutritionDataLabel.leadingAnchor.constraint(equalTo: bookingView.leadingAnchor, constant: 156),
            nutritionDataLabel.trailingAnchor.constraint(equalTo: bookingView.trailingAnchor, constant: -Theme.margin),
            
            bookingView.topAnchor.constraint(equalTo: hotelView.bottomAnchor, constant: 8),
            bookingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bookingView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bookingView.heightAnchor.constraint(greaterThanOrEqualToConstant: 304),
            
            // MARK: - Customer view constraints
            
            customerInfoLabel.topAnchor.constraint(equalTo: customerView.topAnchor, constant: Theme.margin),
            customerInfoLabel.leadingAnchor.constraint(equalTo: customerView.leadingAnchor, constant: Theme.margin),
            customerInfoLabel.trailingAnchor.constraint(equalTo: customerView.trailingAnchor, constant: -Theme.margin),
            customerInfoLabel.heightAnchor.constraint(equalToConstant: 26),

            phoneTextField.topAnchor.constraint(equalTo: customerInfoLabel.bottomAnchor, constant: 20),
            phoneTextField.leadingAnchor.constraint(equalTo: customerView.leadingAnchor, constant: Theme.margin),
            phoneTextField.trailingAnchor.constraint(equalTo: customerView.trailingAnchor, constant: -Theme.margin),
            phoneTextField.heightAnchor.constraint(equalToConstant: 52),
            
            emailTextField.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 8),
            emailTextField.leadingAnchor.constraint(equalTo: customerView.leadingAnchor, constant: Theme.margin),
            emailTextField.trailingAnchor.constraint(equalTo: customerView.trailingAnchor, constant: -Theme.margin),
            emailTextField.heightAnchor.constraint(equalToConstant: 52),
            
            customerDescLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 8),
            customerDescLabel.leadingAnchor.constraint(equalTo: customerView.leadingAnchor, constant: Theme.margin),
            customerDescLabel.trailingAnchor.constraint(equalTo: customerView.trailingAnchor, constant: -Theme.margin),
            customerDescLabel.heightAnchor.constraint(equalToConstant: 34),
            
            customerView.topAnchor.constraint(equalTo: bookingView.bottomAnchor, constant: 8),
            customerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            customerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            customerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 232),

            // MARK: - First tourist view constraints
            
            firstTouristInfoLabel.centerYAnchor.constraint(equalTo: firstTouristTitleView.centerYAnchor),
            firstTouristInfoLabel.leadingAnchor.constraint(equalTo: firstTouristTitleView.leadingAnchor),
            
            firstTouristInfoLabel.heightAnchor.constraint(equalToConstant: 26),
            
            firstTouristCollapseButton.heightAnchor.constraint(equalToConstant: 32),
            firstTouristCollapseButton.widthAnchor.constraint(equalToConstant: 32),
            firstTouristCollapseButton.centerYAnchor.constraint(equalTo: firstTouristTitleView.centerYAnchor),
            firstTouristCollapseButton.trailingAnchor.constraint(equalTo: firstTouristTitleView.trailingAnchor),
            
            firstTouristTitleView.topAnchor.constraint(equalTo: firstTouristView.topAnchor),
            firstTouristTitleView.leadingAnchor.constraint(equalTo: firstTouristView.leadingAnchor, constant: Theme.margin),
            firstTouristTitleView.trailingAnchor.constraint(equalTo: firstTouristView.trailingAnchor, constant: -Theme.margin),
            firstTouristTitleView.heightAnchor.constraint(equalToConstant: 58),
            
            nameTextField.heightAnchor.constraint(equalToConstant: 52),
            surnameTextField.heightAnchor.constraint(equalToConstant: 52),
            birthDateTextField.heightAnchor.constraint(equalToConstant: 52),
            citizenshipTextField.heightAnchor.constraint(equalToConstant: 52),
            passportNumberTextField.heightAnchor.constraint(equalToConstant: 52),
            passportEspDateField.heightAnchor.constraint(equalToConstant: 52),
            
            firstTouristStackView.topAnchor.constraint(equalTo: firstTouristTitleView.bottomAnchor),
            firstTouristStackView.leadingAnchor.constraint(equalTo: firstTouristView.leadingAnchor, constant: Theme.margin),
            firstTouristStackView.trailingAnchor.constraint(equalTo: firstTouristView.trailingAnchor, constant: -Theme.margin),
            firstTouristStackView.bottomAnchor.constraint(equalTo: firstTouristView.bottomAnchor, constant: -Theme.margin),
            
            firstTouristView.topAnchor.constraint(equalTo: customerView.bottomAnchor, constant: 8),
            firstTouristView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            firstTouristView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            // MARK: - Second tourist view constraints
            
            secondTouristInfoLabel.centerYAnchor.constraint(equalTo: secondTouristTitleView.centerYAnchor),
            secondTouristInfoLabel.leadingAnchor.constraint(equalTo: secondTouristTitleView.leadingAnchor),
            
            secondTouristInfoLabel.heightAnchor.constraint(equalToConstant: 26),
            
            secondTouristCollapseButton.heightAnchor.constraint(equalToConstant: 32),
            secondTouristCollapseButton.widthAnchor.constraint(equalToConstant: 32),
            secondTouristCollapseButton.centerYAnchor.constraint(equalTo: secondTouristTitleView.centerYAnchor),
            secondTouristCollapseButton.trailingAnchor.constraint(equalTo: secondTouristTitleView.trailingAnchor),
            
            secondTouristTitleView.centerYAnchor.constraint(equalTo: secondTouristView.centerYAnchor),
            secondTouristTitleView.leadingAnchor.constraint(equalTo: secondTouristView.leadingAnchor, constant: Theme.margin),
            secondTouristTitleView.trailingAnchor.constraint(equalTo: secondTouristView.trailingAnchor, constant: -Theme.margin),
            
            secondTouristView.topAnchor.constraint(equalTo: firstTouristView.bottomAnchor, constant: 8),
            secondTouristView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            secondTouristView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            secondTouristView.heightAnchor.constraint(equalToConstant: 58),
            
            // MARK: - Add tourist view constraints
            
            addTouristInfoLabel.centerYAnchor.constraint(equalTo: addTouristTitleView.centerYAnchor),
            addTouristInfoLabel.leadingAnchor.constraint(equalTo: addTouristTitleView.leadingAnchor),
            
            addTouristInfoLabel.heightAnchor.constraint(equalToConstant: 26),
            
            addTouristCollapseButton.heightAnchor.constraint(equalToConstant: 32),
            addTouristCollapseButton.widthAnchor.constraint(equalToConstant: 32),
            addTouristCollapseButton.centerYAnchor.constraint(equalTo: addTouristTitleView.centerYAnchor),
            addTouristCollapseButton.trailingAnchor.constraint(equalTo: addTouristTitleView.trailingAnchor),
            
            addTouristTitleView.centerYAnchor.constraint(equalTo: addTouristView.centerYAnchor),
            addTouristTitleView.leadingAnchor.constraint(equalTo: addTouristView.leadingAnchor, constant: Theme.margin),
            addTouristTitleView.trailingAnchor.constraint(equalTo: addTouristView.trailingAnchor, constant: -Theme.margin),
            
            addTouristView.topAnchor.constraint(equalTo: secondTouristView.bottomAnchor, constant: 8),
            addTouristView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            addTouristView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            addTouristView.heightAnchor.constraint(equalToConstant: 58),
            
            // MARK: - Price view constraints
            
            tourLabel.topAnchor.constraint(equalTo: priceView.topAnchor, constant: Theme.margin),
            tourLabel.leadingAnchor.constraint(equalTo: priceView.leadingAnchor, constant: Theme.margin),
            
            tourDataLabel.topAnchor.constraint(equalTo: priceView.topAnchor, constant: Theme.margin),
            tourDataLabel.trailingAnchor.constraint(equalTo: priceView.trailingAnchor, constant: -Theme.margin),
            
            fuelChargeLabel.topAnchor.constraint(equalTo: tourDataLabel.bottomAnchor, constant: Theme.margin),
            fuelChargeLabel.leadingAnchor.constraint(equalTo: priceView.leadingAnchor, constant: Theme.margin),
            
            fuelChargeDataLabel.topAnchor.constraint(equalTo: fuelChargeLabel.topAnchor),
            fuelChargeDataLabel.trailingAnchor.constraint(equalTo: priceView.trailingAnchor, constant: -Theme.margin),
            
            serviceChargeLabel.topAnchor.constraint(equalTo: fuelChargeDataLabel.bottomAnchor, constant: Theme.margin),
            serviceChargeLabel.leadingAnchor.constraint(equalTo: priceView.leadingAnchor, constant: Theme.margin),
            
            serviceChargeDataLabel.topAnchor.constraint(equalTo: serviceChargeLabel.topAnchor),
            serviceChargeDataLabel.trailingAnchor.constraint(equalTo: priceView.trailingAnchor, constant: -Theme.margin),
            
            paymentLabel.topAnchor.constraint(equalTo: serviceChargeDataLabel.bottomAnchor, constant: Theme.margin),
            paymentLabel.leadingAnchor.constraint(equalTo: priceView.leadingAnchor, constant: Theme.margin),
            
            paymentDataLabel.topAnchor.constraint(equalTo: paymentLabel.topAnchor),
            paymentDataLabel.trailingAnchor.constraint(equalTo: priceView.trailingAnchor, constant: -Theme.margin),
            
            priceView.topAnchor.constraint(equalTo: addTouristView.bottomAnchor, constant: 8),
            priceView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            priceView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            priceView.heightAnchor.constraint(equalToConstant: 156),
            
            // MARK: - Bottom view constraints
            
            bottomView.topAnchor.constraint(equalTo: priceView.bottomAnchor, constant: 8),
            bottomView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 72),
            
            // MARK: - Content view constraints
            
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    @objc private func hideKeyboard() {
        endEditing(true)
    }
    
    private func setPosition(for textField: UITextField, offset: Int) {
        DispatchQueue.main.async {
            if let newPosition = textField.position(from: textField.beginningOfDocument, offset: offset) {
                
                textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
            }
        }
    }
    
    private func showErrorInTextField(_ textField: UITextField) {
        textField.layer.backgroundColor = Theme.errorTextFieldColor.cgColor
    }
    
    private func resetTextField(_ textField: UITextField) {
        textField.layer.backgroundColor = Theme.wrapperViewColor.cgColor
    }
}

extension BookingView: BookingViewViewModelDelegate {
    func didLoadBookingData() {
        guard let bookingData = viewModel.bookingLoadedData else { return }
        
        starsLabel.text = "★ \(bookingData.horating) \(bookingData.ratingName)"
        titleLabel.text = bookingData.hotelName
        addressButton.setTitle(bookingData.hotelAdress, for: .normal)
        departureDataLabel.text = bookingData.departure
        arrivalDataLabel.text = bookingData.arrivalCountry
        datesDataLabel.text = "\(bookingData.tourDateStart) – \(bookingData.tourDateStop)"
        nightsNumberDataLabel.text = "\(bookingData.numberOfNights) ночей"
        hotelNameDataLabel.text = bookingData.hotelName
        roomDataLabel.text = bookingData.room
        nutritionDataLabel.text = bookingData.nutrition
        tourDataLabel.text = "\(bookingData.tourPrice) ₽"
        fuelChargeDataLabel.text = "\(bookingData.fuelCharge) ₽"
        serviceChargeDataLabel.text = "\(bookingData.serviceCharge) ₽"
        paymentSum = bookingData.tourPrice + bookingData.fuelCharge +     bookingData.serviceCharge
        paymentDataLabel.text = "\(paymentSum) ₽"
        
        bottomView.buttonTitle = "Оплатить \(paymentSum) ₽"
    }
}

extension BookingView: BottomButtonViewDelegate {
    func didTapButton() {
        if inputPhoneText.count != 10 {
            print("Incorrect Phone: \(inputPhoneText)")
            phoneTextField.becomeFirstResponder()
        } else if !inputEmailText.isEmail {
            print("Incorrect Email: \(inputEmailText)")
            emailTextField.becomeFirstResponder()
        } else {
            delegate?.didTapButton()
            
            print("Phone: \(inputPhoneText)")
            print("Email: \(inputEmailText)")
        }
    }
}


extension BookingView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,    replacementString string:  String) -> Bool {
        // MARK: - If Delete button click
        let char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        
        if textField == phoneTextField {
            var result = Array(phoneMask)

            if isBackSpace == -92 {
                if inputPhoneText.count > 0 {
                    inputPhoneText.removeLast()
                }
            } else {
                if inputPhoneText.count == 0, string != "9" {
                    return false
                }
                if inputPhoneText.count < 10 {
                    inputPhoneText += string
                }
            }
            
            var offset = 4
            
            for digit in inputPhoneText {
                if let index = result.firstIndex(of: "*") {
                    result[index] = digit
                    offset = Int(index)
                }
            }

            textField.text = result.map { String($0) }.joined()
            if inputPhoneText.count > 0 {
                offset += 1
            }
            setPosition(for: textField, offset: offset)
        } else if textField == emailTextField {
            if isBackSpace == -92 {
                if inputEmailText.count > 0 {
                    inputEmailText.removeLast()
                }
            } else {
                inputEmailText += string
            }
            
            textField.text = inputEmailText
        }
        
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == phoneTextField {
            resetTextField(textField)
            var offset = 4
            if let text = phoneTextField.text {
                if text == "" {
                    textField.text = phoneMask
                } else {
                    if let index = Array(text).firstIndex(of: "*") {
                        offset = Int(index)
                    } else {
                        offset = text.count
                    }
                }
                setPosition(for: textField, offset: offset)
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            if textField == phoneTextField {
                if text.firstIndex(of: "*") == nil {
                    resetTextField(textField)
                } else {
                    showErrorInTextField(textField)
                }
            } else if textField == emailTextField {
                if text.isBlank || !text.isEmail {
                    showErrorInTextField(textField)
                } else {
                    resetTextField(textField)
                }
            }
        }
        
        textField.resignFirstResponder()
    }
    
    // For pressing return on the keyboard to dismiss keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        for textField in self.subviews where textField is UITextField {
            textField.resignFirstResponder()
        }
        return true
    }
}

