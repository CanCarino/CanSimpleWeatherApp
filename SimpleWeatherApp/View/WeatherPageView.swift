//
//  DetailView.swift
//  SimpleWeatherApp
//
//  Created by Carino, Can on 31.05.2023.
//

import Foundation
import SwiftUI




struct WeatherPageView: View {
    
    @StateObject var networkManager = NetworkManager()
    var cityName: String
    
    @State var isPressed = false
    
    var body: some View {
        VStack {
            //Spacer()
            if isPressed {
                CitySelectionPageView()
            } else {
                VStack{
                    Text("\(self.cityName)")
                        .font(.system(size: 40, weight: .medium, design: .default))
                        .foregroundColor(.blue)
                        .padding()
                    Text("Current : \(networkManager.weather?.currentTemperature ?? 0) C")
                    Text("Feels Like : \(networkManager.weather?.feelsLike ?? 0) C")
                    HStack{
                        Text("H : \(networkManager.weather?.highestTemperature ?? 0) C")
                        Text("L : \(networkManager.weather?.lowestTemperature ?? 0) C")}}
                Divider()
                
                Spacer()
                VStack{
                    Text("Humidity : \(networkManager.weather?.humidity ?? 0) %")
                        .background(RoundedRectangle(cornerRadius: 5).stroke())
                    Spacer()
                    Text("Wind Speed : \(networkManager.weather?.wind ?? 0) m/s")
                        .background(RoundedRectangle(cornerRadius: 5).stroke())
                    Spacer()
                    Text("Pressure : \(networkManager.weather?.seaLevel ?? 0) Pa")
                        .background(RoundedRectangle(cornerRadius: 5).stroke())
                    Spacer()
                    HStack{
                        Text("Coordinates : ")
                        VStack{
                            Text("lat : \(networkManager.weather?.coordinates.latitude ?? 0)")
                            Text("lon : \(networkManager.weather?.coordinates.longitude ?? 0)")
                        }
                       
                    }.background(RoundedRectangle(cornerRadius: 5).stroke())
                    Spacer()
                }
                Divider()
                Spacer()
            
                Text("Description : \(networkManager.weather?.weatherDescription ?? String(0))")
                
            }
            Divider()
                .overlay(
                    TabBarView(isPressed: $isPressed)
                        .padding(.bottom, 8)
                )
            
        }.onAppear {
            self.networkManager.fetchCity(cityName: cityName)
        }
                /*HStack{
                    Spacer()
                    Button(action:{
                        isPressed = false
                    }){
                        Text("City info")
                    }
                    Spacer()
                    Button(action: {
                        isPressed = true
                    })
                    {
                        Text("The cities")
                    }
                    
                    Spacer()
                }*/
                

    }

}

struct TabBarView: View {
    @Binding var isPressed: Bool
    
    var body: some View {
        HStack {
            Spacer()
            
            Button(action: {
                isPressed = false
            }) {
                VStack {
                    Image(systemName: "cloud.fill")
                }
            }
            Spacer()
            
            Button(action: {
                isPressed = true
            }) {
                VStack {
                    Image(systemName: "location.circle")
                }
            }
            
            Spacer()
        }
    }
}

struct WeatherPageView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherPageView(cityName: "Istanbul")
    }
}


//Text("\(String(describing: weatherManager.fetchCity(cityName: "Paris")))")
