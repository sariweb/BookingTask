//
//  BookingView.swift
//  BookingTask
//
//  Created by Sergei on 19.09.2023.
//

import UIKit

protocol BookingViewDelegate: AnyObject {
    func didTapButton()
    func updateUI()
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
    
    // MARK: - Hotel info view
    
    private var hotelInfoView: HotelInfoView = {
        let view = HotelInfoView()
        
        return view
    }()

    // MARK: - Booking view
    
    private var bookingView: BookingInfoView = {
        let view = BookingInfoView()
        
        return view
    }()

    // MARK: - Customer view
    
    private var customerView: BookingCustomerView = {
        let view = BookingCustomerView()
        
        return view
    }()
    
    // MARK: - Tourists stack view
    
    private var touristsStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Theme.wrapperViewColor
        view.axis = .vertical
        view.spacing = 8

        return view
    }()
    
    // MARK: - Add Tourist view

    lazy private var touristAdditionView: BookingTouristAdditionView = {
        let view = BookingTouristAdditionView()
        view.layer.cornerRadius = BookingView.viewCornerRadius
        view.backgroundColor = .white
        view.title = "Добавить туриста"

        return view
    }()
    
    // MARK: - Price view
    
    private var priceView: BookingPriceView = {
        let view = BookingPriceView()
        
        return view
    }()
    
    // MARK: - Transition button view
    
    private var transitionButtonView: TransitionButtonView = {
        let view = TransitionButtonView()
        
        return view
    }()
    
    // MARK: - Bottom view
    
    private var bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        
        return view
    }()
    
    private(set) var touristViews: [BookingTouristView] = []

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        addTouristView()

        contentView.addSubview(hotelInfoView)
        contentView.addSubview(bookingView)
        contentView.addSubview(customerView)
        contentView.addSubview(touristsStackView)
        contentView.addSubview(touristAdditionView)
        contentView.addSubview(priceView)
        contentView.addSubview(bottomView)
        bottomView.addSubview(transitionButtonView)
        
        transitionButtonView.delegate = self
        touristAdditionView.delegate = self
        
        addSubview(contentView)
        
        viewModel.delegate = self
        viewModel.fetchBookingData()

        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapAdd() {
        print("didTapAdd")
        addTouristView()
    }
    
    private func addTouristView() {
        touristViews.append(BookingTouristView())
        
        for i in 0..<touristViews.count {
            let view = touristViews[i]
            view.title = ordinalTitle(i)
            
            if !touristsStackView.arrangedSubviews.contains(where: { v in
                v == view
            }) {
                touristsStackView.addArrangedSubview(view)
            }
        }
        
        invalidateIntrinsicContentSize()
    }
    
    private func ordinalTitle(_ number: Int) -> String {
        let ordinals = ["Первый","Второй","Третий","Четвертый","Пятый","Шестой","Седьмой","Восьмой","Девятый","Десятый"]
        if number < ordinals.count {
            return "\(ordinals[number]) турист"
        } else {
            return "Еще турист"
        }
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            // MARK: - Hotel info view constraints
            
            hotelInfoView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            hotelInfoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            hotelInfoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            // MARK: - Booking view constraints
            
            bookingView.topAnchor.constraint(equalTo: hotelInfoView.bottomAnchor, constant: 8),
            bookingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bookingView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            // MARK: - Customer view constraints
            
            customerView.topAnchor.constraint(equalTo: bookingView.bottomAnchor, constant: 8),
            customerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            customerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            // MARK: - Tourist stack view constraints

            touristsStackView.topAnchor.constraint(equalTo: customerView.bottomAnchor, constant: 8),
            touristsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            touristsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            // MARK: - Add tourist view constraints

            touristAdditionView.topAnchor.constraint(equalTo: touristsStackView.bottomAnchor, constant: 8),
            touristAdditionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            touristAdditionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            // MARK: - Price view constraints
            
            priceView.topAnchor.constraint(equalTo: touristAdditionView.bottomAnchor, constant: 8),
            priceView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            priceView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            // MARK: - Bottom view constraints
            
            bottomView.topAnchor.constraint(equalTo: priceView.bottomAnchor, constant: 8),
            bottomView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 88),
            
            transitionButtonView.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 12),
            transitionButtonView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: Theme.margin),
            transitionButtonView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -Theme.margin),

            // MARK: - Content view constraints
            
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    override var intrinsicContentSize: CGSize {
        let targetSize = CGSize(width: bounds.width, height: UIView.layoutFittingCompressedSize.height)
        return contentView.systemLayoutSizeFitting(targetSize)
    }
}

extension BookingView: BookingViewViewModelDelegate {
    func didLoadBookingData() {
        guard let bookingData = viewModel.bookingLoadedData else { return }
        
        hotelInfoView.rating = "\(bookingData.horating) \(bookingData.ratingName)"
        hotelInfoView.title = bookingData.hotelName
        hotelInfoView.address =  bookingData.hotelAdress
        
        bookingView.departure = bookingData.departure
        bookingView.arrival = bookingData.arrivalCountry
        bookingView.dates = "\(bookingData.tourDateStart) – \(bookingData.tourDateStop)"
        bookingView.nightsNumber = bookingData.numberOfNights
        bookingView.hotelName = bookingData.hotelName
        bookingView.room = bookingData.room
        bookingView.nutrition = bookingData.nutrition
        
        priceView.tourPrice = bookingData.tourPrice
        priceView.fuelCharge = bookingData.fuelCharge
        priceView.serviceCharge = bookingData.serviceCharge
        paymentSum = bookingData.tourPrice + bookingData.fuelCharge + bookingData.serviceCharge
        priceView.paymentSum = paymentSum
        
        transitionButtonView.buttonTitle = "Оплатить \(paymentSum) ₽"
    }
}

extension BookingView: TransitionButtonViewDelegate {
    func didTapButton() {
        if customerView.inputPhoneText.count != 10 {
            print("Incorrect Phone: \(customerView.inputPhoneText)")
//            phoneTextField.becomeFirstResponder()
        } else if !customerView.inputEmailText.isEmail {
            print("Incorrect Email: \(customerView.inputEmailText)")
//            emailTextField.becomeFirstResponder()
        } else {
            delegate?.didTapButton()
            
            print("Phone: \(customerView.inputPhoneText)")
            print("Email: \(customerView.inputEmailText)")
        }
    }
}

extension BookingView: BookingTouristAdditionViewDelegate {
    func didTapAddTourist() {
        addTouristView()
        delegate?.updateUI()
    }
}
