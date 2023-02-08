//
//  File.swift
//  Clima
//
//  Created by Mercedes Martinez Milantchi on 2/6/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

struct WeatherManager {
    var delegate: WeatherManagerDelegate?
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=d107e64a83935fb95aafe7864d6e1952&units=imperial"
    
    // "q={cityName}"
    func fetchWeather(cityName: String) {
        let encodedCityName = cityName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        let urlString = weatherURL + "&q=\(encodedCityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = weatherURL + "&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        // 1. Create URL
        if let url = URL(string: urlString) {
            // 2. Create a URLSession
            let session = URLSession(configuration: .default)
            
            // 3. Give it a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return // this exits the function if there were an error
                }
                
                if let safeData = data {
//                    let dataString = String(data: safeData, encoding: .utf8)
//                    print(dataString)
                    if let weather = parseJSON(safeData) {
                        delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            
            // 4. Start the task
            task.resume()
            }
        }
    
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
//            print(decodedData.main.temp)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
//            print(weather.temperatureString)
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
}
    



