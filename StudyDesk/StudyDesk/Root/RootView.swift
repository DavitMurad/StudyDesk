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
            }
            Tab("Favourites", systemImage: "heart.fill") {
                FavouritesView()
            }
        }
        .tint(Color("CustomBlue"))
        .environmentObject(ARViewModel())

    }
}
