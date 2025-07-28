//
//  CatalogSheet.swift
//  StudyDesk
//
//  Created by Davit Muradyan on 27.07.25.
//

import SwiftUI

struct CatalogSheet: View {
    @ObservedObject private var ARvm = ARViewModel()
    @Binding var modelName: String?
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        LazyVStack {
            ForEach(ARvm.items) { item in
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white)
                        .frame(height: 75)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .shadow(radius: 10)
                    
                    HStack {
                        Image(systemName: item.image)
                            .frame(width: 50, height: 50)
                            .background(.white)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                            .padding()
                            .padding(.horizontal, 10)
                         
                         
                        Text(item.displayName)
                            .font(.headline)
                        Spacer()
                        
                    }
                   
                }
                .onTapGesture {
                    modelName = item.modelName
                    dismiss()
                }
            }
        }
    }
}
