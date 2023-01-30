//
//  DateExtension.swift
//  WeatherKitApp-Storyboard
//
//  Created by Jan Konieczny on 30.01.23.
//

import Foundation
extension Date {
    func weekDay() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        let weekDay = dateFormatter.string(from: self )
        return weekDay
    }
}
