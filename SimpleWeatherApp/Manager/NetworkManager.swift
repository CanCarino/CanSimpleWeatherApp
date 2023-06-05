//
//  NetworkManager.swift
//  SimpleWeatherApp
//
//  Created by Carino, Can on 31.05.2023.
//

import Foundation


class NetworkManager: ObservableObject, Identifiable {
    
    @Published var cities: [Cities] = []
    
    @Published var weather: WeatherPageModel?
    
    
    /*let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=dc4cc656ce4f2c3292583a67e2b50c6d"*/
    
    /*let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=d0218bd466d2c23aba755cc58627dfb9"*/
    
    /*let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=54ff820c3e53b9d506b37d4f0a582ece"*/
    
    /*let weatherURL =  "https://api.openweathermap.org/data/2.5/weather?appid=998576a87c77c8b8d18ffe4e7f0eecc7"*/
    
    
    
    
    func fetchAllCities() /*async throws */{
        let citiesArray: [String] = ["London","Paris","İstanbul","Kuwait","Tokyo","Lille","Jeddah","Chicago"]
        
        for i in citiesArray{
            let urlString = "\(self.weatherURL)&q=\(i)"
            self.requestCityData(urlString: urlString)
        }
        
    }
    
    func fetchCity(cityName: String) /*-> WeatherPageModel? */{
        let urlString = "\(self.weatherURL)&units=metric&q=\(cityName)"
        self.requestWeatherData(urlString: urlString)
        //return self.weather
    }
    
    func requestCityData(urlString: String) {
        //1 URL
        if let url = URL(string: urlString) {
            //2 URL Session
            let session = URLSession(configuration: .default)
            
            //3 Give the task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    self.decodeCityData(weatherData: safeData)
                    
                }
            }
            
            //4 start task
            task.resume()
            
        }
        
    }
    
    func requestWeatherData(urlString: String) {
        //1 URL
        if let url = URL(string: urlString) {
            //2 URL Session
            let session = URLSession(configuration: .default)
            
            //3 Give the task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.decodeWeatherData(weatherData: safeData) {
                        DispatchQueue.main.async {
                            self.weather = weather
                        }
                        
                     }
                
                    }
                }
            //4 start task
            task.resume()
            }
            
        }
        
    
    
    func decodeCityData(weatherData: Data) {
        let decoder = JSONDecoder()
        do {
            let results = try decoder.decode(Cities.self, from: weatherData)
            DispatchQueue.main.async {
                self.cities.append(results)
            }
            
        } catch {
            print(error)
        }
        
    }
    
    
    func decodeWeatherData(weatherData: Data) -> WeatherPageModel? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(WeatherData.self, from: weatherData)
            //var secondPage = WeatherPageModel(cityName: "", currentTemperature: 0, feelsLike: 0, highestTemperature: 0, lowestTemperature: 0, humidity: 0, wind: 0, seaLevel: 0, coordinates: (latitude: 0, longitude: 0), weatherDescription: "")
            
            //DispatchQueue.main.async {
                let name = decodeData.name
                let feel = decodeData.main.feels_like
                let max = decodeData.main.temp_max
                let min = decodeData.main.temp_min
                let humidity = decodeData.main.humidity
                let level = decodeData.main.pressure
                let speed = decodeData.wind.speed
                let latitude = decodeData.coord.lat
                let longitude = decodeData.coord.lon
                let temp = decodeData.main.temp
                let descp = decodeData.weather[0].description
                    
                
                let weatherPage = WeatherPageModel(cityName: name, currentTemperature: temp, feelsLike: feel, highestTemperature: max, lowestTemperature: min, humidity: humidity, wind: speed, seaLevel: level, coordinates: (latitude,longitude), weatherDescription: descp)
                
            //}
            return weatherPage


            
        } catch {
            print(error)
            return nil
        }
        
    }
     

    
}
