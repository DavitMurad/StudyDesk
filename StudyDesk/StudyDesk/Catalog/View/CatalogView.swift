//
//  CatalogView.swift
//  StudyDesk
//
//  Created by Davit Muradyan on 16.07.25.
//

import SwiftUI

struct CatalogView: View {
    @EnvironmentObject var arVM: ARViewModel
    @ObservedObject var favouritesViewModel = FavouritesViewModel()
    @State var itemAngle = 0.0

    let columns = [
        GridItem(.adaptive(minimum: 120), spacing: 20)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    Section {
                        ForEach($arVM.items) { $item in
                            NavigationLink {
                                DetailView(currentItem: item)
                            } label: {
                                VStack(spacing: 10) {
                                    Image(systemName: item.image)
                                        .font(.title)
                                        .foregroundColor(Color("CustomBlue"))
                                    
                                    Text(item.displayName)
                                        .font(.footnote)
                                        .fontWeight(.semibold)
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(.primary)
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(.white)
                                        .shadow(color: .black.opacity(0.05), radius: 6, x: 0, y: 4)
                                )
                                .rotation3DEffect(.degrees(itemAngle), axis: (x: 0 , y: 1, z: 0))
                                .overlay(
                                    Button {
                                        item.liked.toggle()
                                        arVM.like(item: item)
                                    } label: {
                                        Image(systemName: item.liked ? "heart.fill" : "heart")
                                            .foregroundColor(item.liked ? .red : .gray)
                                    }
                                    .padding(8),
                                    alignment: .topTrailing
                                )
                            }
                        }
                    } header: {
                        HStack {
                            Text("Catalog")
                                .font(.largeTitle).bold()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.bottom, 10)
                            
                            Button("Randomize") {
                                withAnimation(.easeInOut(duration: 0.6)) {
                                    arVM.items = arVM.items.shuffled()
                                    itemAngle = 360
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    itemAngle = 0
                                }
                            }
                        }
                    }
                }
                .padding()
                .background(Color(.systemGroupedBackground).ignoresSafeArea())
                .toolbar(.hidden)
                
            }
        }
        .environmentObject(arVM)
    }
}


//#Preview {
//    CatalogView()
//}
