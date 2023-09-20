//
//  Extensions.swift
//  BookingTask
//
//  Created by Sergei on 20.09.2023.
//

import UIKit

extension UIColor {
   convenience init(rgb: UInt) {
      self.init(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0, blue: CGFloat(rgb & 0x0000FF) / 255.0, alpha: CGFloat(1.0))
   }
}

extension UIFont {
    func withFamily(_ family: String) -> UIFont {
        let newDescriptor = fontDescriptor.withFamily(family)
        return UIFont(descriptor: newDescriptor, size: pointSize)
    }
}

extension UITextField {
    func paddingLeft(inset: CGFloat){
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: inset, height: self.frame.height))
        self.leftViewMode = UITextField.ViewMode.always
    }
}

