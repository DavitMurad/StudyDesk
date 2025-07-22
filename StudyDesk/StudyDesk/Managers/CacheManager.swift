//
//  ModelCache.swift
//  StudyDesk
//
//  Created by Davit Muradyan on 19.07.25.
//

import Foundation

class CacheManager {
    static let shared = CacheManager()
    
    private init() {}
    
    private var cache = NSCache<NSString, NSData>()
    
    func get(key: String) -> Data? {
        return cache.object(forKey: key as NSString) as Data?
    }
    
    func set(data: Data, key: String) {
        cache.setObject(data as NSData, forKey: key as NSString)
    }
}
