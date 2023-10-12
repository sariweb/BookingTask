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
        
    private var conteinerView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 8
        
        return view
    }()
    
    private var contentView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Theme.wrapperViewColor
        view.axis = .vertical
        view.spacing = 8
        
        return view
    }()
    
    // MARK: - Hotel info view
    
    private var hotelInfoView: HotelInfoView = {
        let view = HotelInfoView()
        
        return view
    }()

    // MARK: - Booking view
    
    private var bookingInfoView: BookingInfoView = {
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
        view.title = "Добавить туриста"

        return view
    }()
    
    lazy private var touristsDataView: BookingTouristsDataView = {
        let view = BookingTouristsDataView()

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

        contentView.addArrangedSubview(UIView(frame: .zero))
        contentView.addArrangedSubview(hotelInfoView)
        contentView.addArrangedSubview(bookingInfoView)
        contentView.addArrangedSubview(customerView)
        contentView.addArrangedSubview(touristsDataView)
        contentView.addArrangedSubview(touristAdditionView)
        contentView.addArrangedSubview(priceView)
        contentView.addArrangedSubview(UIView(frame: .zero))
        
        bottomView.addSubview(transitionButtonView)
        
        transitionButtonView.delegate = self
        touristAdditionView.delegate = self
        
        conteinerView.addArrangedSubview(contentView)
        conteinerView.addArrangedSubview(bottomView)
        
        addSubview(conteinerView)

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
            // MARK: - Contaner view constraints
            
            conteinerView.topAnchor.constraint(equalTo: topAnchor),
            conteinerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            conteinerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            conteinerView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),
            
            // MARK: - Bottom view constraints
            
            bottomView.heightAnchor.constraint(equalToConstant: 88),

            transitionButtonView.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 12),
            transitionButtonView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: Theme.margin),
            transitionButtonView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -Theme.margin),
        ])
    }
    
    override var intrinsicContentSize: CGSize {
        let targetSize = CGSize(width: bounds.width, height: UIView.layoutFittingCompressedSize.height)
        return conteinerView.systemLayoutSizeFitting(targetSize)
    }
}

extension BookingView: BookingViewViewModelDelegate {
    func didLoadBookingData() {
        guard let bookingData = viewModel.bookingLoadedData else { return }
        
        hotelInfoView.rating = "\(bookingData.horating) \(bookingData.ratingName)"
        hotelInfoView.title = bookingData.hotelName
        hotelInfoView.address =  bookingData.hotelAdress
        
        bookingInfoView.departure = bookingData.departure
        bookingInfoView.arrival = bookingData.arrivalCountry
        bookingInfoView.dates = "\(bookingData.tourDateStart) – \(bookingData.tourDateStop)"
        bookingInfoView.nightsNumber = bookingData.numberOfNights
        bookingInfoView.hotelName = bookingData.hotelName
        bookingInfoView.room = bookingData.room
        bookingInfoView.nutrition = bookingData.nutrition
        
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
        } else if !customerView.inputEmailText.isEmail {
            print("Incorrect Email: \(customerView.inputEmailText)")
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
