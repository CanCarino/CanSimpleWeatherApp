//
//  SecondPageData.swift
//  SimpleWeatherApp
//
//  Created by Carino, Can on 31.05.2023.
//

import Foundation

struct WeatherPageModel {    
    
    // First part of the screen
    let cityName: String
    var currentTemperature: Double
    let feelsLike: Double
    let highestTemperature: Double
    let lowestTemperature: Double
    
    // Second part of the screen
    let humidity: Int
    var wind: Double
    let seaLevel: Int
    let coordinates: (latitude: Double, longitude: Double)
    
    // Third part of the screen
    let weatherDescription: String
    
}
