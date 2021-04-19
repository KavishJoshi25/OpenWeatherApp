//
//  RightNowView.swift
//  OpenWeatherApp
//
//  Created by Kavish Joshi on 4/18/21.
//

import UIKit

class RightNowView: FancyView {
    
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var weatherLabel: UILabel!
    @IBOutlet private weak var temperature: UILabel!
    
    @IBOutlet private weak var dayOfWeekLabel: UILabel!
    @IBOutlet private weak var dayLabel: UILabel!
    @IBOutlet private weak var maxTempLabel: UILabel!
    @IBOutlet private weak var minTempLabel: UILabel!
    
    var weatherInfo: Result? {
        didSet {
            
            if let city = weatherInfo?.name {
                self.cityLabel.text = city
            }
            if let weather = weatherInfo?.weather.first?.weatherDescription {
                self.weatherLabel.text = weather.capitalized
            }
            self.setDayAndDate()
            self.dayLabel.text = "TODAY"
            if let temp = weatherInfo?.main.temp {
                self.temperature.text = WeatherManager.convertTemp(temp: temp, from: .kelvin, to: .celsius, tempStringUnit: .withDegree)
            }
            self.dayOfWeekLabel.text = WeatherManager.getDayOfWeek(date: Date())
            
            if let tempMin = weatherInfo?.main.tempMin {
                self.maxTempLabel.text =  "MinT:" + WeatherManager.convertTemp(temp: tempMin, from: .kelvin, to: .celsius, tempStringUnit: .withDegree)
            }
            
            if let tempMax = weatherInfo?.main.tempMax {
                self.minTempLabel.text = "MaxT:" + WeatherManager.convertTemp(temp: tempMax, from: .kelvin, to: .celsius, tempStringUnit: .withDegree)
            }
        }
    }
    
    
    private func setDayAndDate()  {
        self.dateLabel.text =  Date.getCurrentDate()
    }
}
