//
//  ViewController.swift
//  WeatherKitApp-Storyboard
//
//  Created by Jan Konieczny on 30.01.23.
//

import UIKit
import WeatherKit

class WeeklyForecastTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    private let weeklyForecastCellIdentifier = "weeklyForecastCellIdentifier"
    let notificationCenter = NotificationCenter.default
    var weather: Weather? {
        didSet {
            DispatchQueue.main.async {
                self.reloadData()
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.dataSource = self
        self.delegate = self
        self.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        notificationCenter.addObserver(self, selector: #selector(weatherHasUpdate(_:)), name: .weatherHasUpdate, object: weather)
    }
    
    @objc func weatherHasUpdate(_ notification: Notification){
        let weather = notification.object as? Weather
        self.weather = weather
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let weather {
            return weather.dailyForecast.forecast.count
        } else {
            return 6
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: weeklyForecastCellIdentifier, for: indexPath) as! WeeklyForecastCell
        cell.backgroundColor = .clear
        if let weather {
            let dayWeather = weather.dailyForecast.forecast[indexPath.row]
            cell.label.text = dayWeather.date.weekDay()
            cell.symbolView.image = UIImage(systemName: dayWeather.symbolName)
            cell.partycypationLabel.text = ("\((dayWeather.precipitationChance * 100).roundDouble())%")
        }
        return cell
    }
}
