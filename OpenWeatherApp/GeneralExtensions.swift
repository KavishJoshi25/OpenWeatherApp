//
//  GeneralExtensions.swift
//  OpenWeatherApp
//
//  Created by Kavish Joshi on 4/18/21.
//
import Foundation
import UIKit

enum DateFormats: String {
    case yyyyMMdd = "yyyy-MM-dd"
    case yyyyMMddHHmmssZ = "yyyy-MM-dd HH:mm:ssZ"
    case yyyyMMddHHmm = "yyyy-MM-dd HH:mm"
    case yyyyMMddHHmmss = "yyyy-MM-dd HH:mm:ss"
    case MMMddyyyy = "MMMM dd, yyyy"
    case EdMMMyyyyHHmmssZ = "E, d MMM yyyy HH:mm:ss Z"
}

extension String {
     func toDate(format: DateFormats) -> Date? {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format.rawValue
        return formatter.date(from: self)
    }
}

extension Date {
    
    static func getCurrentDate() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: Date())
        
    }
    
    public var removeTimeStamp : Date? {
          guard let date = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: self)) else {
           return nil
          }
          return date
      }
    
    func toString(format: DateFormats) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format.rawValue
        return formatter.string(from: self)
    }
    
    func dateAndTimetoString(format: DateFormats) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format.rawValue
        return formatter.string(from: self)
    }
    
    static func getHourFrom(date: Date) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .none
        var string = dateFormatter.string(from: date)
        if string.last == "M" {
            string = String(string.prefix(string.count - 3))
        }
        return string
    }
    
}


extension UIViewController {

    func presentOkAlertController(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true, completion: nil)
    }

    func presentErrorAlertController(error: String) {
        let ac = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(ac, animated: true, completion: nil)
    }
}

extension Array where Element: Hashable {
    func removeDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()
        return filter { addedDict.updateValue(true, forKey: $0) == nil }
    }
    
}

extension Array {
    func unique<T: Hashable>(by keyPath: KeyPath<Element, T>) -> [Element] {
        var set = Set<T>()
        return self.reduce(into: [Element]()) { result, value in
            guard !set.contains(value[keyPath: keyPath]) else {
                return
            }
            set.insert(value[keyPath: keyPath])
            result.append(value)
        }
    }
}
