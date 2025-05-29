//
//  Weather.swift
//  WeatherApp
//
//  Created by Mesut As on 29.05.2025.
//

import Foundation

struct WeatherResponse: Decodable {
    let main: Main
    let weather: [Weather]
    let name: String
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let description: String
    let icon: String
}
    
