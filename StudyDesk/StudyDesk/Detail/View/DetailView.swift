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
    var currentItem: ARItem?
    var body: some View {
        GeometryReader { geom in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(detailVM.modifiedItem) { item in
                        ExtractedView(geom: geom, item: item, modelName: $modelName)
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
            }
        }
    }
}

struct ExtractedView: View {

    let geom: GeometryProxy
    let item: ARItem
    @Binding var modelName: String?
    
    @EnvironmentObject var catalogVM: CatalogViewModel
    @EnvironmentObject var arVM: ARViewModel
    var body: some View {
        VStack {
            USDZQuickLook(modelName: item.modelName)
                .frame(height: geom.size.height / 2)
                .ignoresSafeArea(edges: [.top])
            
            Group {
                Text(item.displayName)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Rectangle()
                    .frame(height: 1)
                
                Text(item.description)
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .minimumScaleFactor(0.7)
           
                
                Button {
                    arVM.like(item: item)
                } label: {
                    Image(systemName: item.liked ? "heart.fill" : "heart")
                        .foregroundColor(item.liked ? .red : .gray)
                        .font(.title)
                }
                .padding(.vertical)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Scroll to see more items")
                    .font(.caption)
                Spacer()
                
            }
            .padding(.horizontal)
        }
    }
}
