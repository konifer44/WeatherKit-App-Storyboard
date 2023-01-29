//
//  NotificationCenterExtension.swift
//  WeatherKitApp-Storyboard
//
//  Created by Jan Konieczny on 22.01.23.
//

import Foundation

extension Notification.Name {
    static var weatherHasUpdate: Notification.Name {
        return .init(rawValue: "weatherHasUpdate") }
}
