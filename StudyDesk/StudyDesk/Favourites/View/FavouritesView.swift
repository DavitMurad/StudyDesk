//
//  FavouritesView.swift
//  StudyDesk
//
//  Created by Davit Muradyan on 16.07.25.
//

import SwiftUI

struct FavouritesView: View {
    @EnvironmentObject var arVM: ARViewModel

    var body: some View {
        NavigationView {
            List {
                ForEach(arVM.favouritesVM.favoritesItems) { fav in
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
                            arVM.like(item: fav)
                        } label: {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.red)
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.vertical, 8)
                }
                .onDelete(perform: delete)
            }
            .navigationTitle("Favourites")
        }
    }
    
    func delete(indexSet: IndexSet) {
        arVM.favouritesVM.favoritesItems.remove(atOffsets: indexSet)
        
    }
}


//#Preview {
//    FavouritesView()
//}
