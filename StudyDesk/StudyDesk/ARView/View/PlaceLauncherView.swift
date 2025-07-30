//
//  PlaceLauncherView.swift
//  StudyDesk
//
//  Created by Davit Muradyan on 27.07.25.
//

import SwiftUI
struct PlaceLauncherView: View {
    @State private var showAR = false
    @State private var imageOffset: CGSize = .zero
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Spacer()
                Image("ar")
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .frame(maxWidth: .infinity)
                    .frame(height: 300)
                    .padding(.horizontal)
                    .offset(imageOffset)
                    .gesture(
                        DragGesture()
                            .onChanged({ value in
                                withAnimation(.spring) {
                                    if value.translation.height < 70 &&  value.translation.height > -100   {
                                        imageOffset = value.translation
                                    }
                                }
                            })
                            .onEnded({ value in
                                withAnimation(.spring) {
                                    imageOffset = .zero
                                }
                            })
                    )
                Text("Grab your Mac, coffee, and questionable motivation. Let’s go.")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Button(action: {
                    showAR = true
                }) {
                    Label("Start Setting Up Your Desk", systemImage: "arkit")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color("CustomBlue").gradient)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .padding(.horizontal)
                }
            }
        }
        .onAppear(perform: {
            NotificationManager.shared.requestAuthorization()
            NotificationManager.shared.scheduleNotifications()
        })
        .fullScreenCover(isPresented: $showAR) {
            ARMainView()
        }
    }
}

//#Preview {
//    PlaceLauncherView()
//}
