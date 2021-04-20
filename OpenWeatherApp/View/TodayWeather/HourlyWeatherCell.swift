//
//  HourlyWeatherCell.swift
//  OpenWeatherApp
//
//  Created by Kavish Joshi on 4/19/21.
//

import UIKit

class HourlyWeatherCell: UICollectionViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var weatherImgView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    
    var isNight = false
    
    var forecast: FList? {
        didSet {
            if let data = forecast {
                
                 let timeData = data.dtTxt 
                    let dateComp = timeData.components(separatedBy: " ")
                    let dateStr = dateComp.last ?? ""
                    
                    let df = DateFormatter()
                    df.dateFormat = "HH:mm:ss"
                    df.timeZone = NSTimeZone(name: "UTC") as TimeZone?
                    let date = df.date(from: dateStr)
                    
                    df.dateFormat = "Ha"
                    if let dt = date {
                        let convertedDate = df.string(from: dt)
                        timeLabel.text = convertedDate
                        if convertedDate.contains("PM") {
                            isNight = true
                        } else {
                            isNight = false
                        }
                    }
                
                
                if let weatherId = data.weather?.first?.id {
                    let imgString = WeatherManager.getWeatherSysImgName(weather:  weatherId , isNight: isNight)
                    weatherImgView.image = UIImage(systemName: imgString)
                }
                
                if let temp = data.main?.temp {
                    tempLabel.text = WeatherManager.convertTemp(temp: temp, from: .kelvin, to: .celsius, tempStringUnit: .withDegree)
                }
            }
        }
    }
}
