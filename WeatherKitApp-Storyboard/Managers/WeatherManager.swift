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
    private let notificationCenter = NotificationCenter.default
    private let monitor = NWPathMonitor()
    let locationManager = LocationManager()
    var weather: Weather? {
        didSet{
            notificationCenter.post(name: .weatherHasUpdate, object: weather)
        }
    }
    
    func requestWeather() async {
        guard let userLocation = locationManager.userLocation else { return }
        do {
            let weather = try await WeatherService.shared.weather(for: userLocation)
            self.weather = weather
        } catch {
            print("\(error.localizedDescription)")
        }
    }
    
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
