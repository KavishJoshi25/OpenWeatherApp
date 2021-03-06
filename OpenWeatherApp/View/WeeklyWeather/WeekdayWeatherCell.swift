//
//  WeekdayWeatherCell.swift
//  OpenWeatherApp
//
//  Created by Kavish Joshi on 4/19/21.
//

import UIKit

class WeekdayWeatherCell: UICollectionViewCell {
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherImgView: UIImageView!
    @IBOutlet weak var tempMaxLabel: UILabel!
    @IBOutlet weak var tempMinLabel: UILabel!
    
    var forecast: WeeklyForecast? {
        didSet {
            if let data = forecast {
                let df = DateFormatter()
                df.timeZone = NSTimeZone(name: "UTC") as TimeZone?
                df.dateFormat = "yyyy-MM-dd"
                if let date = df.date(from: data.date) {
                    let dow = WeatherManager.getDayOfWeek(date: date)
                    dayLabel.text = dow
                }
                tempMaxLabel.text = WeatherManager.convertTemp(temp: data.temp_max, from: .kelvin, to: .celsius, tempStringUnit: .nonDegree)
                tempMinLabel.text = WeatherManager.convertTemp(temp: data.temp_min, from: .kelvin, to: .celsius, tempStringUnit: .nonDegree)
            }
        }
    }
    
}
