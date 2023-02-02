//
//  ViewController.swift
//  WeatherKitApp-Storyboard
//
//  Created by Jan Konieczny on 16.01.23.
//

import UIKit
import WeatherKit
import NotificationCenter

class ViewController: UIViewController {
    let notificationCenter = NotificationCenter.default
    let locationManager = LocationManager()
    let weatherManager = WeatherManager()
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var conditionsLabel: UILabel!
    @IBOutlet weak var hightTemperatureLabel: UILabel!
    @IBOutlet weak var lowtemperatureLabel: UILabel!
    
    @IBOutlet weak var label: UILabel!

    @IBOutlet weak var weeklyForecastTableView: WeeklyForecastTableView!
    
    
    var weather: Weather? {
        didSet {
            refreshData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weeklyForecastTableView.backgroundColor = .clear
        addNotificationObserver()
        getCityName()
        Task {
            await weatherManager.requestWeather()
        }
    }
    
    @objc func weatherHasUpdate(_ notification: Notification){
        let weather = notification.object as? Weather
        self.weather = weather
    }
    
    func getCityName(){
        DispatchQueue.main.async {
            self.locationManager.getCityforCurrentLocation { city, error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    self.cityLabel.text = city ?? "Unknown City"
                }
            }
        }
    }
    
    func addNotificationObserver(){
        notificationCenter.addObserver(self, selector: #selector(weatherHasUpdate(_:)), name: .weatherHasUpdate, object: weather)
        
    }
    
    func refreshData(){
        getCityName()
        DispatchQueue.main.async {
            if let weather = self.weather {
                self.temperatureLabel.text = "\(weather.currentWeather.temperature.value.roundDouble())°C"
                self.conditionsLabel.text = weather.currentWeather.condition.description
                self.hightTemperatureLabel.text = ("H: \(weather.dailyForecast.forecast.first?.highTemperature.value.roundDouble() ?? "--")°C")
                self.lowtemperatureLabel.text = ("L: \(weather.dailyForecast.forecast.first?.lowTemperature.value.roundDouble() ?? "--")°C")
            }
        }
    }
}

