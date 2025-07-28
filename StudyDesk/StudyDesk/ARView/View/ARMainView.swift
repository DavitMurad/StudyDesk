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
            
            Text("Go to Catalog and select desired student essentials!")

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



//
//#Preview {
//    CatalogSheet()
//}
