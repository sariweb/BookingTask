//
//  APICacheManager.swift
//  
//
//  Created by Sergei on 07.09.2023.
//

import Foundation

/// Manages in memory session scoped API caches
final class APICacheManager {
    private var cacheDictionary: [
        Endpoint: NSCache<NSString, NSData>
    ] = [:]
    
    // MARK: - Init
    
    init() {
        setupCache()
    }
    
    // MARK: - Public
    
    public func cachedResponse(for endpoint: Endpoint, url: URL?) -> Data? {
        guard let targetCache = cacheDictionary[endpoint],
              let url = url
        else { return nil }
        
        let key = url.absoluteString as NSString
        return targetCache.object(forKey: key) as Data?
    }
    
    public func setCache(for endpoint: Endpoint, url: URL?, data: Data) {
        guard let targetCache = cacheDictionary[endpoint],
              let url = url
        else { return }
        
        let key = url.absoluteString as NSString
        targetCache.setObject(data as NSData, forKey: key)
    }
    
    
    // MARK: - Private
    
    private func setupCache() {
        Endpoint.allCases.forEach { endpoint in
            cacheDictionary[endpoint] = NSCache<NSString, NSData>()
        }
    }
}
