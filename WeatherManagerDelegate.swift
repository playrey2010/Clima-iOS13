//
//  WeatherManagerDelegate.swift
//  Clima
//
//  Created by Mercedes Martinez Milantchi on 2/7/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    
    func didFailWithError(error: Error)
}
