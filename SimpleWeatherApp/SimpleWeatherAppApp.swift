//
//  SimpleWeatherAppApp.swift
//  SimpleWeatherApp
//
//  Created by Carino, Can on 31.05.2023.
//

import SwiftUI

@main
struct SimpleWeatherAppApp: App {
    var body: some Scene {
        WindowGroup {
            WeatherPageView(cityName: "Istanbul")
        }
    }
}
