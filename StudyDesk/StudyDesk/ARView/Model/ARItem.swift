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
    var modelName: String
    let audio: String?
    let image: String
    var liked: Bool
    var selected: Bool
    let description: String
}
