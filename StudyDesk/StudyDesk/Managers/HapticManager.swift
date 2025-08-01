//
//  HapticManager.swift
//  StudyDesk
//
//  Created by Davit Muradyan on 31.07.25.
//

import Foundation
import SwiftUI


class HapticManager {
    static let shared = HapticManager()
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
       let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}
