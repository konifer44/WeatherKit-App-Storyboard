//
//  ViewController.swift
//  WeatherKitApp-Storyboard
//
//  Created by Jan Konieczny on 16.01.23.
//

import UIKit
import WeatherKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var conditionsLabel: UILabel!
    @IBOutlet weak var hightTemperatureLabel: UILabel!
    @IBOutlet weak var lowtemperatureLabel: UILabel!
    

    var weatherManager = WeatherManager()
    var weather: Weather?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        DispatchQueue.main.async {
            self.weatherManager.locationManager.getCityforCurrentLocation { city, error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    self.cityLabel.text = city ?? "Unknown City"
                }
            }
        }
        
        
        Task {
            self.weather = await weatherManager.requestWeatherForCurrentLocation()
            print(self.weather?.currentWeather.condition as Any)
        }
    }


}

