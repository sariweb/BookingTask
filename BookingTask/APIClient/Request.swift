//
//  Request.swift
//  
//
//  Created by Sergei on 27.08.2023.
//

import Foundation

/// Object that represent a single API call
final class Request {
    
    /// API constants
    private struct Constants {
        static let baseUrl = "https://run.mocky.io/v3"
    }
    
    /// Path components for API if any
    private let pathComponents: [String]
    
    /// Query parameters for API if any
    private let queryParameters: [URLQueryItem]
    
    /// Constracted url for api request in string format
    private var urlString: String {
        var string = Constants.baseUrl
        string += "/"
        string += endpoint.rawValue
        
        if !pathComponents.isEmpty {
            pathComponents.forEach {
                string += "/\($0)"
            }
        }
        
        if !queryParameters.isEmpty {
            string += "?"
            let argString = queryParameters.compactMap {
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
            }.joined(separator: "&")
            string += argString
        }
        return string
    }
    
    // MARK: - Public
    
    /// Desired endpoint
    public let endpoint: Endpoint
    
    /// Computed and constracted API url
    public var url: URL? {
        return URL(string: urlString)
    }
    
    /// Desired http method
    public let httpMethod = "GET"
    
    /// Construct request
    /// - Parameters:
    ///   - endpoint: Target endpoint
    ///   - pathComponents: Collection of path components
    ///   - queryParameters: Collection for query parameters
    init(endpoint: Endpoint,
         pathComponents: [String] = [],
         queryParameters: [URLQueryItem] = []) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
    
    /// Attempt tocreate request
    /// - Parameter url: URL to parse
    convenience init?(url: URL) {
        let string = url.absoluteString
        if !string.contains(Constants.baseUrl) {
            return nil
        }
        let trimmed = string.replacingOccurrences(of: Constants.baseUrl + "/", with: "")
        if trimmed.contains("/") {
            let components = trimmed.components(separatedBy: "/")
            if !components.isEmpty {
                let endpointString = components[0] // Endpoint
                var pathComponents: [String] = []
                if components.count > 1 {
                    pathComponents = components
                    pathComponents.removeFirst()
                }
                if let Endpoint = Endpoint(
                    rawValue: endpointString
                ) {
                    self.init(endpoint: Endpoint, pathComponents: pathComponents)
                    return
                }
            }
        } else if trimmed.contains("?") {
            let components = trimmed.components(separatedBy: "?")
            if !components.isEmpty, components.count >= 2 {
                let endpointString = components[0]
                let queryItemsString = components[1]
                // value=name&value=name
                let queryItems: [URLQueryItem] = queryItemsString.components(separatedBy: "&").compactMap({
                    guard $0.contains("=") else {
                        return nil
                    }
                    let parts = $0.components(separatedBy: "=")
                    
                    return URLQueryItem(
                        name: parts[0],
                        value: parts[1]
                    )
                })
                
                if let Endpoint = Endpoint(rawValue: endpointString) {
                    self.init(endpoint: Endpoint, queryParameters: queryItems)
                    return
                }
            }
        }
        
        return nil
    }
}

extension Request {
    static let hotelRequest = Request(endpoint: .hotel)
    static let roomRequest = Request(endpoint: .room)
    static let bookingRequest = Request(endpoint: .booking)
}
