//
//  ARMainView.swift
//  StudyDesk
//
//  Created by Davit Muradyan on 16.07.25.
//

import SwiftUI

struct ARMainView: View {
    @State private var isSheetPresented = false
    @State private var modelName: String? = nil
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            ARViewContainer(modelName: $modelName)
                .ignoresSafeArea()

            VStack {
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.backward")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(12)
                            .background(Color.black.opacity(0.5))
                            .clipShape(Circle())
                    }

                    Spacer()
                }
                .padding(.top, 50)
                .padding(.horizontal)

                Spacer()
            }
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        isSheetPresented = true
                    }) {
                        Image(systemName: "square.grid.2x2.fill")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .clipShape(Circle())
                            .shadow(radius: 10)
                    }
                    .padding()
                }
            }
        }
        .sheet(isPresented: $isSheetPresented) {
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
