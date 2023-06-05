//
//  File.swift
//  SimpleWeatherApp
//
//  Created by Carino, Can on 31.05.2023.
//

import Foundation

//General data structure (for parseJSON2)
struct WeatherData: Codable {
    let name: String
    let main: Main
    let wind: Wind
    let coord: Coord
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let temp_max: Double
    let temp_min: Double
    let humidity: Int
    let pressure: Int
}

struct Weather: Codable {
    let description: String
}

struct Wind: Codable {
    let speed: Double
}

struct Coord: Codable {
    let lon: Double
    let lat: Double
}

//List of the cities (for parseJSON1)
struct Cities: Codable, Identifiable {
    let id: Int
    let name: String
}

