//
//  DoubleExtension.swift
//  WeatherKitApp-Storyboard
//
//  Created by Jan Konieczny on 18.01.23.
//

import Foundation

extension Double {
    func roundDouble() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0 //maximum digits in Double after dot (maximum precision)
        return String(formatter.string(from: number) ?? "")
    }
}
