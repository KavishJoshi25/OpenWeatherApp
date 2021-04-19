//
//  WeatherLayoutAttributes.swift
//  OpenWeatherApp
//
//  Created by Kavish Joshi on 4/19/21.
//

import UIKit

class WeatherLayoutAttributes: UICollectionViewLayoutAttributes {
    var initialOrigin: CGPoint = .zero
    var headerAlpha: CGFloat = .zero
    
    override func copy(with zone: NSZone? = nil) -> Any {
        guard let copiedAttributes = super.copy(with: zone) as? WeatherLayoutAttributes else {
            return super.copy(with: zone)
        }
        copiedAttributes.initialOrigin = initialOrigin
        copiedAttributes.headerAlpha = headerAlpha
        return copiedAttributes
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let otherAttributes = object as? WeatherLayoutAttributes else {
            return false
        }
        if otherAttributes.initialOrigin != initialOrigin || otherAttributes.headerAlpha != headerAlpha {
            return false
        }
        return super.isEqual(object)
    }
}
