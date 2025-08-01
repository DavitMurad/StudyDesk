//
//  DetailView.swift
//  StudyDesk
//
//  Created by Davit Muradyan on 23.07.25.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var arVM: ARViewModel
    @Environment(\.dismiss) var dismiss
    @StateObject var detailVM = DetailViewModel()
    @State var modelName: String? = nil
    @State private var currentIndex = 0
    var currentItem: ARItem?
    
    var body: some View {
        GeometryReader { geom in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(Array($detailVM.modifiedItem.enumerated()), id: \.element.id) { index, $item in
                        ItemView(geom: geom, item: $item, currentIndex: index)
                            .environmentObject(detailVM)
                            .environmentObject(arVM)
                            .frame(width: geom.size.width)
                            .toolbar(.hidden, for: .tabBar)
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.paging)
            .scrollBounceBehavior(.basedOnSize)
        }
        .onAppear {
            if let item = currentItem, detailVM.modifiedItem.isEmpty {
                modelName = item.modelName
                detailVM.determineCurrentView(arVM: arVM, item: item)
                
                if let index = detailVM.modifiedItem.firstIndex(where: { $0.id == item.id }) {
                    currentIndex = index
                }
            }
        }
    }
}

