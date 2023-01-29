//
//  HourlyForecast.swift
//  WeatherKitApp-Storyboard
//
//  Created by Jan Konieczny on 17.01.23.
//

import Foundation
import UIKit
import WeatherKit
import NotificationCenter

private let hourlyForecastCellIdentifer = "hourlyForecastCellIdentifer"

class HourlyForecastView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate{
    
    var weather: Weather? {
        didSet {
            DispatchQueue.main.async {
                self.reloadData()
            }
            
        }
    }
    let notificationCenter = NotificationCenter.default
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.dataSource = self
        self.delegate = self
        
        notificationCenter.addObserver(self, selector: #selector(weatherHasUpdate(_:)), name: .weatherHasUpdate, object: weather)
    }
    
    
    @objc func weatherHasUpdate(_ notification: Notification){
        let weather = notification.object as? Weather
        self.weather = weather
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let weather {
            let shortenedHourWeather =
            Array(weather.hourlyForecast.filter { hourlyWeather in
                return hourlyWeather.date.timeIntervalSince(Date()) > 0
            }.prefix(24)
            )
            return shortenedHourWeather.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: hourlyForecastCellIdentifer, for: indexPath) as? HourlyForecastCell else {
            fatalError("Can't dequeue cell")
        }
        if let weather {
            let shortenedHourWeather =
            Array(weather.hourlyForecast.filter { hourlyWeather in
                return hourlyWeather.date.timeIntervalSince(Date()) > 0
            }.prefix(24)
            )
            
           
            
            let hourForecast = shortenedHourWeather[indexPath.row]
            cell.hourLabel.text = Calendar.current.component(.hour, from: hourForecast.date).description
            cell.weatherSymbol.image = UIImage(systemName: hourForecast.symbolName)
            cell.temperatureLabel.text = "\(hourForecast.temperature.value.roundDouble())°"
        }
        
        return cell
    }
    
}
