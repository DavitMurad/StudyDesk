//
//  FavouritesView.swift
//  StudyDesk
//
//  Created by Davit Muradyan on 16.07.25.
//

import SwiftUI

struct FavouritesView: View {
    @EnvironmentObject var arVM: ARViewModel
    
    var favoriteItems: [ARItem] {
        arVM.items.filter { $0.liked }
    }
    
    var body: some View {
        NavigationView {
            if favoriteItems.isEmpty {
                ContentUnavailableView {
                    Label("No favourites yet", systemImage: "heart.slash")
                } description: {
                    Text("Add your favourite items to see them here")
                }
            }
            else {
                List {
                    ForEach(favoriteItems) { fav in
                        HStack {
                            Image(systemName: fav.image)
                                .foregroundStyle(Color("CustomBlue"))
                                .frame(width: 40, height: 40)
                                .background(Color.white)
                                .clipShape(Circle())
                                .shadow(radius: 2)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(fav.displayName)
                                    .font(.headline)
                                Text("Tap heart to remove")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            
                            Button {
                                if let index = arVM.items.firstIndex(where: { $0.id == fav.id }) {
                                    HapticManager.shared.impact(style: .soft)
                                    arVM.items[index].liked.toggle()
                                    arVM.like(item: arVM.items[index])
                                }
                            } label: {
                                Image(systemName: fav.liked ? "heart.fill" : "heart")
                                    .foregroundColor(fav.liked ? .red : .gray)
                            }
                            .buttonStyle(.plain)
                        }
                        .padding(.vertical, 10)
                    }
                    .onDelete(perform: delete)
                }

                .navigationTitle("Favourites")
            }
        }
    }
    
    func delete(indexSet: IndexSet) {
        let itemsToDelete = indexSet.map { favoriteItems[$0] }
        
        for item in itemsToDelete {
            if let index = arVM.items.firstIndex(where: { $0.id == item.id }) {
                arVM.items[index].liked = false
                arVM.like(item: arVM.items[index])
            }
        }
    }
}
