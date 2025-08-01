//
//  ModelFetcher.swift
//  StudyDesk
//
//  Created by Davit Muradyan on 20.07.25.
//

import Foundation

import Combine

class ModelFetcher {
    static let shared = ModelFetcher()
    
    func fetchModel(name: String) -> AnyPublisher<Data, Error> {
        if let cached = CacheManager.shared.get(key: name) {
            return Just(cached)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        if let saved = FileManagerService.shared.load(named: name) {
            CacheManager.shared.set(data: saved, key: name)
            return Just(saved)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        if let url = Bundle.main.url(forResource: name, withExtension: "json") {
            return Just(url)
                .tryMap { url -> Data in
                    let data = try Data(contentsOf: url)
                    CacheManager.shared.set(data: data, key: name)
                    return data
                }
                .eraseToAnyPublisher()
        }
        
        return Fail(error: URLError(.fileDoesNotExist))
            .eraseToAnyPublisher()
    }
}
