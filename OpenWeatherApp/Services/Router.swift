//
//  Router.swift
//  OpenWeatherApp
//
//  Created by Kavish Joshi on 4/18/21.
//

enum Router {
    case todaysForcast
    case fivedaysForcast
    
    var accessToken: String {
        return "fae7190d7e6433ec3a45285ffcf55c86"
    }
    
    var scheme: String{
        switch self {
        case .todaysForcast, .fivedaysForcast:
            return "http"
        }
    }
    
    var host: String {
        switch self {
        case .todaysForcast, .fivedaysForcast:
            return "api.openweathermap.org"
        }
    }
    
    var path: String{
        switch self {
        case .todaysForcast:
            return "/data/2.5/weather"
        case .fivedaysForcast:
            return "/data/2.5/forecast"
        }
    }
    
    
    var method: String {
        switch self {
        case .todaysForcast, .fivedaysForcast:
            return "GET"
        }
    }
}
