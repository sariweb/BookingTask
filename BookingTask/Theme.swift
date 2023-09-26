//
//  Theme.swift
//  BookingTask
//
//  Created by Sergei on 12.09.2023.
//

import UIKit

struct Theme {
    static let margin: CGFloat = 16
    
    static let addressFont: UIFont = .systemFont(ofSize: 14, weight: .medium).withFamily("SF Pro Display")
    static let smallDescriptionFont: UIFont = .systemFont(ofSize: 14).withFamily("SF Pro Display")
    static let smallButtonFont: UIFont = .systemFont(ofSize: 13, weight: .medium).withFamily("SF Pro Display")
    static let descriptionFont: UIFont = .systemFont(ofSize: 16).withFamily("SF Pro Display")
    static let starsFont: UIFont = .systemFont(ofSize: 16, weight: .medium).withFamily("SF Pro Display")
    static let titleFont: UIFont = .systemFont(ofSize: 22 ,weight: .medium).withFamily("SF Pro Display")
    static let priceFont: UIFont = .systemFont(ofSize: 30, weight: .medium).withFamily("SF Pro Display")
    static let paymentFont: UIFont = .systemFont(ofSize: 16, weight: .semibold).withFamily("SF Pro Display")
    
    static let starsViewColor: UIColor = UIColor.init(rgb: 0xFFC700).withAlphaComponent(0.2)
    static let starsLabelColor: UIColor = UIColor.init(rgb: 0xFFA800)
    static let textButtonColor: UIColor = UIColor.init(rgb: 0x0D72FF)
    static let descriptionColor: UIColor = UIColor.init(rgb: 0x828796)
    static let wrapperViewColor: UIColor = UIColor.init(rgb: 0xF6F6F9)
    static let cellBgColor: UIColor = UIColor.init(rgb: 0xFBFBFC)
    static let cellTextColor: UIColor = UIColor.init(rgb: 0x828796)
    static let optionColor: UIColor = UIColor.init(rgb: 0x2C3035)
    static let buttonColor: UIColor = UIColor.init(rgb: 0x0D72FF)
    static let buttonBgColor: UIColor = UIColor.init(rgb: 0x0D72FF).withAlphaComponent(0.1)
    static let errorTextFieldColor: UIColor = UIColor.init(rgb: 0xEB5757).withAlphaComponent(0.15)
}
