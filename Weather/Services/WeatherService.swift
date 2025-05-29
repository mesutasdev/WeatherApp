//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Mesut As on 29.05.2025.
//

import Foundation

struct WeatherService {
    private let apiKey: String = {
        guard let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path),
              let key = dict["OPENWEATHER_API_KEY"] as? String else {
            fatalError("API Key bulunamadı")
        }
        return key
    }()
    
    func GetWeather(for city: String) async throws -> WeatherResponse {
        
        let cityEncoded = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? city
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(cityEncoded)&appid=\(apiKey)&units=metric"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoded = try JSONDecoder().decode(WeatherResponse.self, from: data)
        
        return decoded
    }
    
}
