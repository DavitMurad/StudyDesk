//
//  ARMainView.swift
//  StudyDesk
//
//  Created by Davit Muradyan on 16.07.25.
//

import SwiftUI

struct ARMainView: View {
    @EnvironmentObject var arVM: ARViewModel
    @State private var isSheetPresented = false
    @State private var modelName: String? = nil
    @Environment(\.dismiss) private var dismiss
    
    @State var count = 10
    @State var finishedText: String? = nil
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
                
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.secondary)
                    .frame(width: 50, height: 50)
                    .padding()
                    .overlay {
                        Text(finishedText ?? "\(count)")
                    }
                    .opacity(modelName == "Coffee" ? 1 : 0)

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
        .onReceive(ARViewContainer.timerPublisher) { _ in
            if count <= 1 {
                finishedText = "Get back to work! Your play time is over."
                ARViewContainer.stopTimer()
            } else {
                count -= 1
            }
        }
        .sheet(isPresented: $isSheetPresented) {
            CatalogSheet(modelName: $modelName)
        }
        .onDisappear {
            for index in arVM.items.indices {
                arVM.items[index].selected = false
            }
        }
    }
}
