//
//  ItemView.swift
//  StudyDesk
//
//  Created by Davit Muradyan on 30.07.25.
//

import SwiftUI

struct ItemView: View {
    let geom: GeometryProxy
    @Binding var item: ARItem
    @EnvironmentObject var arVM: ARViewModel
    @StateObject var detailVM = DetailViewModel()
    let currentIndex: Int
    
    
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
                    HapticManager.shared.impact(style: .soft)
                    item.liked.toggle()
                    arVM.like(item: item)
                } label: {
                    Image(systemName: item.liked ? "heart.fill" : "heart")
                        .foregroundColor(item.liked ? .red : .gray)
                        .font(.title)
                }
                .padding(.vertical)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Scroll **right** or **left** to see more items")
                    .font(.caption)
                    .padding(.vertical)
                
                Spacer()
                HStack {
                    ForEach(0..<arVM.items.count, id: \.self) { i in
                        Circle()
                            .fill(i == currentIndex ? .black : .clear)
                            .overlay(
                                Circle()
                                    .stroke(.primary, lineWidth: 1)
                            )
                            .frame(width: 8, height: 8)
                    }
                }
                .padding()
                
                
            }
            .padding(.horizontal)
        }
    }
    
    func highlightCurrentView(i: Int) -> some ShapeStyle {
        let currentIndex = Int(item.id) ?? 0
        if i == currentIndex - 1 {
            return Color.black
        }
        return Color.clear
    }
}
