//
//  WeatherLayout.swift
//  OpenWeatherApp
//
//  Created by Kavish Joshi on 4/19/21.
//

import UIKit

import UIKit

class WeatherLayout: UICollectionViewFlowLayout {
    enum Element: String {
        case WeatherHeaderView
        case TodayWeatherCell
        case WeeklyWeatherCell
        case SummaryTodayWeatherCell
        case DetailTodayWeatherCell
        
        var id: String {
            return self.rawValue
        }
        
        var kind: String {
            return "Kind\(self.rawValue.capitalized)"
        }
    }
    
    override class var layoutAttributesClass: AnyClass {
        return WeatherLayoutAttributes.self
    }
    
    private var collectionViewWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let inset = collectionView.contentInset
        return collectionView.frame.width - (inset.left + inset.right)
    }
    
    private var collectionViewHeight: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        return collectionView.frame.height
    }
    
    override public var collectionViewContentSize: CGSize {
        return CGSize(width: collectionViewWidth, height: contentHeight)
    }
    
    private var oldBounds = CGRect.zero
    private var cache = [Element: [IndexPath: WeatherLayoutAttributes]]()
    private var visibleAttributes = [WeatherLayoutAttributes]()
    private var contentHeight = CGFloat()
    private var zIndex = 0
    
    private var cellWidth: CGFloat {
        return itemSize.width
    }
    
    private var cellHeight: CGFloat {
        return itemSize.height
    }
    
    var headerSize: CGSize = .zero
    var cellTodayWeatherSize: CGSize = .zero
    var cellWeeklyWeatherSize: CGSize = .zero
    var cellSummaryWeatherSize: CGSize = .zero
    var cellDetailTodayWeatherSize: CGSize = .zero
    
    private var contentOffset: CGPoint {
        guard let collectionView = collectionView else {
            return CGPoint.zero
        }
        return collectionView.contentOffset
    }
}

// MARK: - LAYOUT CORE PROCESS
extension WeatherLayout {
    override func prepare() {
        guard let collectionView = collectionView, cache.isEmpty else { return }
        prepareCache()
        contentHeight = 0
        oldBounds = collectionView.bounds
        
        let headerAttributes = WeatherLayoutAttributes(forSupplementaryViewOfKind: Element.WeatherHeaderView.kind, with: IndexPath(item: 0, section: 0))
        prepareElement(size: headerSize, type: .WeatherHeaderView, attributes: headerAttributes)
        
        let todayWeatherAttributes = WeatherLayoutAttributes(forCellWith: IndexPath(item: 0, section: 0))
        prepareElement(size: cellTodayWeatherSize, type: .TodayWeatherCell, attributes: todayWeatherAttributes)
        
        let weeklyWeatherAttributes = WeatherLayoutAttributes(forCellWith: IndexPath(item: 0, section: 1))
        prepareElement(size: cellWeeklyWeatherSize, type: .WeeklyWeatherCell, attributes: weeklyWeatherAttributes)
        
        let summaryAttributes = WeatherLayoutAttributes(forCellWith: IndexPath(item: 0, section: 2))
        prepareElement(size: cellSummaryWeatherSize, type: .SummaryTodayWeatherCell, attributes: summaryAttributes)
        
        let detailAttributes = WeatherLayoutAttributes(forCellWith: IndexPath(item: 0, section: 3))
        prepareElement(size: cellDetailTodayWeatherSize, type: .DetailTodayWeatherCell, attributes: detailAttributes)
        
        cache[.WeatherHeaderView]?.first?.value.zIndex = zIndex + 1
        cache[.TodayWeatherCell]?.first?.value.zIndex = zIndex + 2
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        if oldBounds.size != newBounds.size {
            cache.removeAll(keepingCapacity: true)
        }
        return true // if the collection view requires a layout update
    }
    
    func prepareCache() {
        cache.removeAll(keepingCapacity: true)
        cache[.WeatherHeaderView] = [IndexPath: WeatherLayoutAttributes]()
        cache[.TodayWeatherCell] = [IndexPath: WeatherLayoutAttributes]()
        cache[.WeeklyWeatherCell] = [IndexPath: WeatherLayoutAttributes]()
        cache[.SummaryTodayWeatherCell] = [IndexPath: WeatherLayoutAttributes]()
        cache[.DetailTodayWeatherCell] = [IndexPath: WeatherLayoutAttributes]()
    }
    
    func prepareElement(size: CGSize, type: Element, attributes: WeatherLayoutAttributes) {
        guard size != .zero else { return }
        
        attributes.initialOrigin = CGPoint(x: 0, y: contentHeight)
        attributes.frame = CGRect(origin: CGPoint(x: 0, y: contentHeight), size: size)
        attributes.zIndex = zIndex
        zIndex += 1
        
        contentHeight  = attributes.frame.maxY
        
        cache[type]?[attributes.indexPath] = attributes
    }
}

// MARK: - PROVIDING ATTRIBUTES TO THE COLLECTIONVIEW
extension WeatherLayout {
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        switch elementKind {
        case Element.WeatherHeaderView.kind:
            return cache[.WeatherHeaderView]?[indexPath]
            
        default:
            return UICollectionViewLayoutAttributes()
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let collectionView = collectionView else { return nil }
        visibleAttributes.removeAll(keepingCapacity: true)
        
        for (type, elementInfo) in cache {
            for (indexPath, attributes) in elementInfo {
                attributes.transform = .identity
                updateStickyViews(type, attributes: attributes, collectionView: collectionView, indexPath: indexPath)
                if attributes.frame.intersects(rect) {
                    visibleAttributes.append(attributes)
                }
            }
        }
        return visibleAttributes
    }
    
    private func updateStickyViews(_ type: Element, attributes: WeatherLayoutAttributes, collectionView: UICollectionView, indexPath: IndexPath) {
        if type == .WeatherHeaderView {
            let limitHeight = headerSize.height - cellTodayWeatherSize.height
            let updatedHeight = headerSize.height - contentOffset.y
            let resultHeight = min(headerSize.height, max(limitHeight, updatedHeight))
            attributes.frame = CGRect(origin: CGPoint(x: 0, y: contentOffset.y), size: CGSize(width: headerSize.width, height: resultHeight))
            attributes.headerAlpha = 1 - (contentOffset.y / cellTodayWeatherSize.height)
        }
        else if type == .TodayWeatherCell {
            let upperLimit = (headerSize.height / 2) + 30
            let initY = upperLimit - headerSize.height
            let updatedY = contentOffset.y - attributes.initialOrigin.y - initY
            attributes.transform = CGAffineTransform(translationX: 0, y: max(0, updatedY))
        }
    }
}
