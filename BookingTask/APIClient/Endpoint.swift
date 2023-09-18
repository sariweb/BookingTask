//
//  Endpoint.swift
//  
//
//  Created by Sergei on 27.08.2023.
//

import Foundation

/// Represents unique API endpoint
@frozen enum Endpoint: String, CaseIterable, Hashable {
    /// Endpoint to get hotel info
    case hotel = "35e0d18e-2521-4f1b-a575-f0fe366f66e3"
    /// Endpoint to get  room info
    case room = "f9a38183-6f95-43aa-853a-9c83cbb05ecd"
    /// Endpoint to get booking info
    case booking = "e8868481-743f-4eb2-a0d7-2bc4012275c8"
}
