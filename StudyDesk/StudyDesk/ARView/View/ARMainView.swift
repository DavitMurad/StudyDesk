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
                            .padding(10)
                            .background(Color.black.opacity(0.5))
                            .clipShape(Circle())
                    }
                    Text("Tap the Catalog. Yes, it has more than just hopes and dreams.")
                        .font(.subheadline)
                        .multilineTextAlignment(.leading)
                        .minimumScaleFactor(0.8)
                        .padding()
                        .frame(height: 75)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .opacity(modelName == nil ? 1:0)
                        
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
                            .background(Color("CustomBlue"))
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


//#Preview {
//    ARMainView()
//}
