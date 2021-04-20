//
//  DetailTodayWeatherCell.swift
//  OpenWeatherApp
//
//  Created by Kavish Joshi on 4/19/21.
//

import UIKit

class DetailTodayWeatherCell: UICollectionViewCell {
    
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var cloudsLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var feelslikeLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    
    
    
    var result: Result? {
        didSet {
            if let data = result {
                                
                //self.timezone = result.timezone
                cloudsLabel.text = String(format: "%d %@", "\(data.clouds.all ?? 0)", "%")
                
                let spd = result?.wind.speed ?? 0
                let speed = Measurement(value: spd, unit: UnitSpeed.metersPerSecond).description
                windLabel.text = String(format: " %@", speed)
                
                
                
                let visibility = data.visibility
                let intVal = Measurement(value: Double(visibility), unit: UnitLength.meters)
                if visibility < 1000 {
                    visibilityLabel.text = intVal.description
                } else {
                    let doubleVal = intVal.converted(to: .kilometers)
                    visibilityLabel.text = doubleVal.description
                }
                
                
                
                    //sunset
                    //sunrise
                    sunriseLabel.text = WeatherManager.convertUnixTime(time: data.sys.sunset, timeZone: Int64(data.timezone))
                    sunsetLabel.text = WeatherManager.convertUnixTime(time: data.sys.sunrise, timeZone: Int64(data.timezone))

                humidityLabel.text = String(format: "%d %@","\(data.main.humidity)" , "%")
                       feelslikeLabel.text = WeatherManager.convertTemp(temp: data.main.feelsLike, from: .kelvin, to: .celsius, tempStringUnit: .withDegree)

                       let pressure = Measurement(value: Double(data.main.pressure), unit: UnitPressure.hectopascals)
                       pressureLabel.text = pressure.description
    
                
            }
        }
    }
    
}
