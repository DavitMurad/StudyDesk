//
//  ARMainView.swift
//  StudyDesk
//
//  Created by Davit Muradyan on 16.07.25.
//

import SwiftUI

struct ARMainView: View {
    @State var isSheetPresent = false
    @State var modelName: String? = nil
    var body: some View {
        ZStack {
            ARViewContainer(modelName: $modelName).ignoresSafeArea(edges: [.top, .horizontal])
            
            VStack {
                Text(modelName ?? "nil")
                Button {
                    isSheetPresent.toggle()
                } label: {
                    Image(systemName: "square.grid.2x2")
                        .font(.title)
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .padding()
            }
        }
        .sheet(isPresented: $isSheetPresent) {
            CatalogSheet(modelName: $modelName)
        }
    }
}

struct CatalogSheet: View {
    @ObservedObject var ARvm = ARViewModel()
    @Binding var modelName: String?
    @Environment(\.dismiss) var dismiss

    var body: some View {
        LazyVStack {
            ForEach(ARvm.items) { item in
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white)
                        .frame(height: 75)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .shadow(radius: 10)
                    
                    HStack {
                        Image(systemName: item.image)
                            .frame(width: 50, height: 50)
                            .background(.white)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                            .padding()
                            .padding(.horizontal, 10)
                         
                         
                        Text(item.displayName)
                            .font(.headline)
                        Spacer()
                        
                    }
                   
                }
                .onTapGesture {
                    modelName = item.modelName
                    dismiss()
                }
            }
        }
    }
}
//
//#Preview {
//    CatalogSheet()
//}
