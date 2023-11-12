//
//  API.swift
//  roomvu-challenge-task
//
//  Created by Mohammad Sadegh Panadgoo on 8/20/1402 AP.
//

import Foundation

enum APP_API {
    enum baseURL {
        static var api: String {
            "https://api.openweathermap.org"
        }
        
        static var pro: String {
            "https://pro.openweathermap.org"
        }
    }
    
    static var apiKey: String {
        "7dd4ed5cb3ba778e378d76a9c85762c4"
    }
    
    enum GeocodingEndpoints {
        static var direct: String {
            "geo/1.0/direct"
        }
    }
    
    enum WeatherEndpoints {
        static var weather: String {
            "data/2.5/weather"
        }
        
        static var hourlyForecast: String {
            "data/2.5/forecast/hourly"
        }
        
        static var forecast: String {
            "data/2.5/forecast"
        }

    }
    
    enum Unit {
        static var standard: String {
            "standard"
        }
        
        static var metric: String {
            "metric"
        }
        
        static var imperial: String {
            "imperial"
        }
        
    }
}
