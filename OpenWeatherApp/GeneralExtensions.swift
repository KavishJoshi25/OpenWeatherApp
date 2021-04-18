//
//  GeneralExtensions.swift
//  OpenWeatherApp
//
//  Created by Kavish Joshi on 4/18/21.
//
import Foundation


extension Date {

 static func getCurrentDate() -> String {

        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"

        return dateFormatter.string(from: Date())

    }
}
