//
//  ARViewModel.swift
//  StudyDesk
//
//  Created by Davit Muradyan on 17.07.25.
//

import Foundation
import Combine
import SwiftUI

class ARViewModel: ObservableObject {
    @Published var items: [ARItem] = []
    private var cancellables = Set<AnyCancellable>()
    var favouritesVM = FavouritesViewModel()
    
    init() {
        getData()
        favouritesVM.fetchItemsByID()
    }
    
    func getData() {
        ModelFetcher.shared.fetchModel(name: "Items")
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .decode(type: [ARItem].self, decoder: JSONDecoder())
            .sink { [weak self]completion in
                switch completion {
                case .finished:
                    print("Successfully loaded data with caching")
                    self?.favouritesVM.filter(items: self?.items ?? [])
                case .failure(let error):
                    print("Error loading data: \(error)")
                }
            } receiveValue: { [weak self] loadedItems in
                self?.items = loadedItems.map { item in
                    var mutableItem = item
                    if self?.favouritesVM.favourites.contains(where: { $0.id == item.id }) == true {
                        mutableItem.liked = true
                        
                    }
                    return mutableItem
                }
            }
            .store(in: &cancellables)
    }
    
    func like(item: ARItem) {
        var copyItem = item
        copyItem.liked.toggle()
        
        if copyItem.liked {
            favouritesVM.addItemById(item.id)
        } else {
            favouritesVM.deleteItemByID(item.id)
        }
        
        items = items.map { existingItem in
            var updated = existingItem
            updated.liked = favouritesVM.favourites.contains(where: { $0.id == existingItem.id })
            return updated
        }
    }
}
