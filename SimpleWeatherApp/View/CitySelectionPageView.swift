//
//  ContentView.swift
//  SimpleWeatherApp
//
//  Created by Carino, Can on 31.05.2023.
//

import SwiftUI

struct CitySelectionPageView: View {
    
    @ObservedObject private var networkManager = NetworkManager()
    @State private var selectedCity: String?
    @State private var isShowingWeatherPageView = false
    
    
    var body: some View {
        VStack{
            NavigationView {
                if let city = selectedCity {
                    if isShowingWeatherPageView {
                        WeatherPageView(cityName: city)
                        
                    }
                } else {
                    List(networkManager.cities) { cities in Button(action: {
                        selectedCity = cities.name
                        isShowingWeatherPageView = true
                    }){
                        Text(cities.name)
                    }}
                    .navigationBarTitle("Select one city : ")
                }}
            .onAppear {
                self.networkManager.fetchAllCities()
            }
            
            /*.task {
                do{
                    try await self.networkManager.fetchAllCities()
                }catch {
                    print(error)
                }
                
            }*/

            
        }
        
    }
    
}





struct CitySelectionPageView_Previews: PreviewProvider {
    static var previews: some View {
        CitySelectionPageView()
    }
}


