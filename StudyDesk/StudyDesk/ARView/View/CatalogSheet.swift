//
//  CatalogSheet.swift
//  StudyDesk
//
//  Created by Davit Muradyan on 27.07.25.
//

import SwiftUI

struct CatalogSheet: View {
    @EnvironmentObject var arVM: ARViewModel
    @Binding var modelName: String?
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack {
            Text("Find a table. No, your knees don't count. AR is not that advanced yet.")
                .font(.callout)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            LazyVStack {
                ForEach($arVM.items) { $item in
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.white)
                            .frame(height: 75)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .shadow(radius: 10)
                        
                        HStack {
                            Image(systemName: item.image)
                                .foregroundStyle(Color("CustomBlue"))
                                .frame(width: 50, height: 50)
                                .background(.white)
                                .clipShape(Circle())
                                .shadow(radius: 2)
                                .padding()
                                .padding(.horizontal, 10)
                            
                            
                            Text(item.displayName)
                                .font(.headline)
                            Spacer()
                            
                            Image(systemName: "chevron.down")
                                .font(.title)
                                .foregroundStyle(Color("CustomBlue"))
                                .opacity(item.selected ? 1.0 : 0.0)
                                .padding()
                                .padding(.horizontal)
                        }
                        
                    }
                    .onTapGesture {
                        modelName = item.modelName
                        item.selected = true
                        dismiss()
                    }
                }
            }
        }
    }
}
