//
//  NotificationManager.swift
//
//  Created by Johan Teekens on 28/09/2016.
//  Copyright © 2016 Steltix. All rights reserved.
//

import UIKit
import UserNotifications

enum NotificationActions: String {
    case notificationID = "notificationidentifier"
}

class NotificationManager: NSObject {
    
    func registerForNotifications(messageText: String) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if granted {
                self.setupAndGenerateLocalNotification(notificationMessage: messageText)
            }
        }
    }
    
    func setupAndGenerateLocalNotification(notificationMessage: String) {
        // Register an Actionable Notification
        _ = UNNotificationAction(identifier: NotificationActions.notificationID.rawValue, title: "Watchlist", options: [])
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Watchlist Notification"
        notificationContent.body = notificationMessage
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let notificationRequestIdentifier = "Request"
        let notificationRequest = UNNotificationRequest(identifier: notificationRequestIdentifier, content: notificationContent, trigger: trigger)
        UNUserNotificationCenter.current().add(notificationRequest) { (error) in
            // handle the error if needed
            print(error)
        }
    }
}

extension NotificationManager: UNUserNotificationCenterDelegate {
    
    private func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: () -> Void) {
        // Response has actionIdentifier, userText, Notification (which has Request, which has Trigger and Content)
        switch response.actionIdentifier {
        case NotificationActions.notificationID.rawValue:
            print("Alert delivered!")
        default: break
        }
    }
    
    private func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: (UNNotificationPresentationOptions) -> Void) {
       print("Foreground alert placeholder")
        
    }
}
