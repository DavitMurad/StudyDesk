//
//  NotificationManager.swift
//  StudyDesk
//
//  Created by Davit Muradyan on 30.07.25.
//

import Foundation
import UserNotifications


struct Reminder {
    let title: String
    let subtitle: String
}

class NotificationManager {
    static let shared = NotificationManager()
    
    let contentArr = [
        Reminder(title: "Back to the grind?", subtitle: "The desk is waiting. So are the deadlines."),
        Reminder(title: "Notebook is lonely.", subtitle: "Might want to start writing things before the exam does."),
        Reminder(title: "Your MacBook’s feeling underutilized.", subtitle: "Time to open that IDE… or pretend to."),
        Reminder(title: "Desk spotted!", subtitle: "Finally, a valid reason to not study on the bed."),
    ]
    
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if let error = error {
                print(error)
            }
            else {
                print("Success")
            }
        }
    }
    
    func scheduleNotifications() {
        let content = UNMutableNotificationContent()
        let contentText = contentArr.randomElement()
        content.title = contentText?.title ?? "Default Title"
        content.subtitle = contentText?.subtitle ?? "Default Subtitle"
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.day = 1
        dateComponents.hour = 10
        dateComponents.minute = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request)

        
    }
}
