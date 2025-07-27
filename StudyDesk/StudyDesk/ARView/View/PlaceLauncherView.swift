//
//  PlaceLauncherView.swift
//  StudyDesk
//
//  Created by Davit Muradyan on 27.07.25.
//

import SwiftUI
struct PlaceLauncherView: View {
    @State private var showAR = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Ready to start placing models?")
                .font(.title)
                .multilineTextAlignment(.center)
                .padding()

            Button(action: {
                showAR = true
            }) {
                Label("Start AR Experience", systemImage: "arkit")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .padding(.horizontal)
            }
        }
        .fullScreenCover(isPresented: $showAR) {
            ARMainView()
        }
    }
}

#Preview {
    PlaceLauncherView()
}
