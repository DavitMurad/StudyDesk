//
//  RootView.swift
//  StudyDesk
//
//  Created by Davit Muradyan on 16.07.25.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            Tab("Place", systemImage: "camera.viewfinder") {
                PlaceLauncherView()
            }
            Tab("Catalog", systemImage: "square.grid.2x2") {
                CatalogView()
                    .environmentObject(ARViewModel())
            }
            Tab("Favourites", systemImage: "heart.fill") {
                FavouritesView()
            }
        }
    }
}

#Preview {
    RootView()
}
