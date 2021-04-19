//
//  WeatherManager.swift
//  OpenWeatherApp
//
//  Created by Kavish Joshi on 4/19/21.
//

import Foundation

enum UnitTemperatureType: String {
    case withDegree // ex. 4°
    case nonDegree // ex. 4
}

class WeatherManager {

    static func convertTemp(temp: Double, from inputTempType: UnitTemperature, to outputTempType: UnitTemperature, tempStringUnit: UnitTemperatureType) -> String {
        let mf = MeasurementFormatter()
        mf.numberFormatter.maximumFractionDigits = 0
        mf.unitOptions = .providedUnit
        let input = Measurement(value: temp, unit: inputTempType)
        let output = input.converted(to: outputTempType)
        
        if outputTempType == UnitTemperature.celsius {
            if tempStringUnit == .withDegree {
                return mf.string(from: output).replacingOccurrences(of: "C", with: "")
            } else if tempStringUnit == .nonDegree {
                return mf.string(from: output).replacingOccurrences(of: "°C", with: "")
            }
        }
        return mf.string(from: output)
    }
    
    static func getDayOfWeek(date: Date) -> String {
        var dow = ""
        
        let calender = Calendar(identifier: .gregorian)
        let comps = calender.dateComponents([.weekday], from: date)
        let today = comps.weekday!
        
        switch today {
        case 1: dow = "Sunday"
        case 2: dow = "Monday"
        case 3: dow = "Tuesday"
        case 4: dow = "Wednesday"
        case 5: dow = "Thursday"
        case 6: dow = "Friday"
        case 7: dow = "Saturday"
        default: dow = ""
        }
        
        return dow
    }
    
}

