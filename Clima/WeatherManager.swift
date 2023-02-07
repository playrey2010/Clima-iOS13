//
//  File.swift
//  Clima
//
//  Created by Mercedes Martinez Milantchi on 2/6/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=d107e64a83935fb95aafe7864d6e1952&units=imperial"
    // "q={cityName}"
    func fetchWeather(cityName: String) {
        let urlString = weatherURL + "&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        // 1. Create URL
        if let url = URL(string: urlString) {
            // 2. Create a URLSession
            let session = URLSession(configuration: .default)
            
            // 3. Give it a task
            let task = session.dataTask(with: url, completionHandler: handle(data:urlResponse:error:))
            
            // 4. Start the task
            task.resume()
            
        }
        
       
    }
    
    func handle(data: Data?, urlResponse: URLResponse?, error: Error?){
        if error != nil {
            print(error!)
            return // this exits the function if there were an error
        }
        
        if let safeData = data {
            let dataString = String(data: safeData, encoding: .utf8)
            print(dataString)
        }
    }
}
