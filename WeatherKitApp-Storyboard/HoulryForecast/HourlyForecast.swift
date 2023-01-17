//
//  HourlyForecast.swift
//  WeatherKitApp-Storyboard
//
//  Created by Jan Konieczny on 17.01.23.
//

import Foundation
import UIKit
import WeatherKit

private let hourlyForecastCellIdentifer = "hourlyForecastCellIdentifer"

class HourlyForecastView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate{
    let weatherManager = WeatherManager()
    var weather: Weather?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.dataSource = self
        self.delegate = self
        
        Task {
            weather = await weatherManager.requestWeatherForCurrentLocation()
            self.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let weather {
            return weather.hourlyForecast.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: hourlyForecastCellIdentifer, for: indexPath) as? HourlyForecastCell else {
            fatalError("Can't dequeue cell")
        }
        return cell
    }
    
}
