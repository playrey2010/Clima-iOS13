//
//  WeatherData.swift
//  Clima
//
//  Created by Maria Mercedes Martinez Milantchi on 06/02/2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    
}


struct Main: Decodable {
    let temp: Double
}
