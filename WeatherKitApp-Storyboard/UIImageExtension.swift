//
//  UIImageExtension.swift
//  WeatherKitApp-Storyboard
//
//  Created by Jan Konieczny on 19.01.23.
//

import Foundation
import UIKit

extension UIImage {
    func isSymbolExist(symbolName: String) -> UIImage {
        if let symbol = UIImage(systemName: "\(symbolName).fill") {
            return symbol
        } else {
            return UIImage(systemName: symbolName) ?? UIImage()
        }
    }
}
