//
//  WeatherFetcher.swift
//  WeatherKitApp
//
//  Created by Jan Konieczny on 05.09.22.
//

import Foundation
import WeatherKit
import CoreLocation
import SwiftUI
import Combine
import Network
import WidgetKit

class WeatherManager {
    var locationManager = LocationManager()
    private let monitor = NWPathMonitor()

//    var shortenedHourWeather: [HourWeather] {
//        if let weather {
//            return Array(weather.hourlyForecast.filter { hourlyWeather in
//                return hourlyWeather.date.timeIntervalSince(Date()) > 0
//            }.prefix(24))
//        } else {
//            return []
//        }
//    }
    
    
    func requestWeatherForCurrentLocation() async -> Weather? {
       guard let userLocation = locationManager.userLocation else { return nil }
        do {
            return try await WeatherService.shared.weather(for: userLocation)
        } catch {
            print("\(error.localizedDescription)")
            return nil
        }
    }
}
