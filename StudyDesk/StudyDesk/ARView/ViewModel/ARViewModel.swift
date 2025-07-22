//
//  ARViewModel.swift
//  StudyDesk
//
//  Created by Davit Muradyan on 17.07.25.
//

import Foundation
import Combine

class ARViewModel: ObservableObject {
    @Published var items: [ARItem] = []
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        getData()
    }
    
    func getData() {
        guard let url = Bundle.main.url(forResource: "Items", withExtension: "json") else { return }
            Just(url)
                .subscribe(on: DispatchQueue.global())
                .receive(on: DispatchQueue.main)
                .tryMap { url -> Data in
                    try Data(contentsOf: url)
                }
                .decode(type: [ARItem].self, decoder: JSONDecoder())
                .sink { completion in
                    switch completion {
                        
                    case .finished:
                        print("Successfully loaded local data")
                    case .failure (let error):
                        print("Error loading local data: \(error)")

                    }
                } receiveValue: { [weak self] loadedItem in
                    self?.items = loadedItem
                }
                .store(in: &cancellable)
    }
}
