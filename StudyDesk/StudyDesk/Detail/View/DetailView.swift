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
    @StateObject var catalogVM = CatalogViewModel()
    @State var modelName: String? = nil
    var currentItem: ARItem?
    var body: some View {
        GeometryReader { geom in
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(catalogVM.modifiedItem) { item in
                        ExtractedView(geom: geom, item: item, modelName: $modelName)
                            .environmentObject(catalogVM)
                            .environmentObject(arVM)
                            .onAppear {
                                catalogVM.determineCurrentView(arVM: arVM, item: item)
                            }
                            .frame(width: geom.size.width)
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.paging)
            .scrollBounceBehavior(.basedOnSize)
        }
        .onAppear {
            if let item = currentItem {
                modelName = item.modelName
                
                catalogVM.determineCurrentView(arVM: arVM, item: item)
            }
            
        }
    }
}

//#Preview {
//    DetailView()
//        .environmentObject(ARViewModel())
//}

struct ExtractedView: View {

    let geom: GeometryProxy
    let item: ARItem
    @Binding var modelName: String?
    
    @EnvironmentObject var catalogVM: CatalogViewModel
    @EnvironmentObject var arVM: ARViewModel
    var body: some View {
        VStack {
            Text(modelName ?? "nil")
            ARViewContainer(modelName: $modelName)
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
//                    .padding(.vertical)
                
                HStack {
                    Text("Favourite")
                        .font(.title2)
                    Spacer()
                    Image(systemName: "heart.fill")
                        .foregroundStyle(.red)
                        .font(.title)
                }
                .padding(.vertical)
                
                Spacer()
                Button("Place") {
                    
                }
                .font(.title2)
                .foregroundStyle(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(.black)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                
            }
            .padding(.horizontal)
//            .onAppear {
//                modelName = item.modelName
//            }
            
        }
       
    }
}
