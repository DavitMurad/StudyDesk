//
//  ARItem.swift
//  StudyDesk
//
//  Created by Davit Muradyan on 16.07.25.
//

import Foundation

struct ARItem: Identifiable, Codable, Equatable {
    let id: String
    let displayName: String
    let modelName: String
    let audio: String?
    let image: String
    let liked: Bool
    let description: String
}
