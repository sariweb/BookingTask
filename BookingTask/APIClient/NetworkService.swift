//
//  NetworkService.swift
//  
//
//  Created by Sergei on 27.08.2023.
//

import Foundation

/// Primary API service to get data
final class NetworkService {
    /// Shared siglton instace
    static let shared = NetworkService()
    
    private let cacheManager = APICacheManager()
    
    /// Privatized constractor
    private init() {}
    
    enum NetworkServiceError: Error {
        case failedToCreateRequest
        case failedToGetData
    }
    
    /// Send API call
    /// - Parameters:
    ///   - request: Request instance
    ///   - type: The type of an object we expect to get back
    ///   - complition: Callback with data or error
    public func execute<T: Codable>(
        _ request: Request,
        expecting type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        if let data = cacheManager.cachedResponse(
            for: request.endpoint,
            url: request.url
        ) {
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                completion(.success(result))
            }
            catch {
                completion(.failure(error))
            }
            
            return
        }
        
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(NetworkServiceError.failedToCreateRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NetworkServiceError.failedToGetData))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                self?.cacheManager.setCache(
                    for: request.endpoint,
                    url: request.url,
                    data: data
                )
                completion(.success(result))
            }
            catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    private func request(from Request: Request) -> URLRequest? {
        guard let url = Request.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = Request.httpMethod
        
        return request
    }
}
