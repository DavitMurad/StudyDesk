//
//  FavouritesViewModel.swift
//  StudyDesk
//
//  Created by Davit Muradyan on 28.07.25.
//

import Foundation
import CoreData
import SwiftUI

class FavouritesViewModel: ObservableObject {
    let container: NSPersistentContainer
    @Published var favourites: [ItemModel] = []
    @Published var favoritesItems: [ARItem] = []
    
    init() {
        container = NSPersistentContainer(name: "ItemModel")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error Loading The Data: \(error)")
            }
        }
        fetchItemsByID()
        
    }
    
    func fetchItemsByID() {
        let request = NSFetchRequest<ItemModel>(entityName: "ItemModel")
        do {
            favourites = try container.viewContext.fetch(request)
            
        } catch let error {
            print("Error fetching \(error)")
        }
    }
    
    func addItemById(_ id: String) {
        let newItem = ItemModel(context: container.viewContext)
        newItem.id = id
        saveData()
    }
    
    func deleteItemByID(_ id: String) {
        if let entity = favourites.first(where: { $0.id == id }) {
            container.viewContext.delete(entity)
            saveData()
        }
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchItemsByID()
        } catch let error {
            print("Error saving \(error)")
        }
    }
    
    
    func filter(items: [ARItem]) {
        favoritesItems = items.filter { item in
            favourites.contains(where: { $0.id == item.id })
        }
    }
    
}
