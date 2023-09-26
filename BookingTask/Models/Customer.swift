//
//  Customer.swift
//  BookingTask
//
//  Created by Sergei on 24.09.2023.
//

import Foundation

struct Customer: Codable {
    let phone: String
    let email: String
    let tourists: [Tourist]
}

struct Tourist: Codable {
    let name: String
    let surname: String
    let birthDate: String // TODO: use Date & datepicker
    let citizenship: String // TODO: use enum & dropdown
    let passportNumber: String
    let passportEspDate: String // TODO: use Date & datepicker
}

