//
//  DetailViewModel.swift
//  StudyDesk
//
//  Created by Davit Muradyan on 28.07.25.
//

import Foundation

class DetailViewModel: ObservableObject {
    @Published var modifiedItem: [ARItem] = []
    
    func determineCurrentView(arVM: ARViewModel, item: ARItem) {
        var modifiedItems = arVM.items
        modifiedItems.removeAll(where: {$0 == item})
        modifiedItems.insert(item, at: 0)
        for i in 0..<modifiedItems.count {
            modifiedItems[i].modelName.append("Centered")
        }
        
        self.modifiedItem = modifiedItems
    }
}
