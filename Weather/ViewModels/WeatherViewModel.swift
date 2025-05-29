//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Mesut As on 29.05.2025.
//

import Foundation

@MainActor

class WeatherViewModel: ObservableObject {
    @Published var city: String = ""
    @Published var temperature: String = ""
    @Published var description: String = ""
    @Published var iconURL: URL?
    @Published var cityName: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let weatherService = WeatherService ()
    
    func fetchWeather() async {
        guard !city.isEmpty else {return}
        isLoading = true
        errorMessage = nil
        
        do {
            let weather = try await weatherService.GetWeather(for: city)
            temperature = "\(Int(weather.main.temp))°C"
            description = translateDescription(weather.weather.first?.description ?? "-")
            cityName = weather.name.replacingOccurrences(of: " Province", with: "")
            iconURL = URL(string: "https://openweathermap.org/img/wn/\(weather.weather.first?.icon ?? "01d")@2x.png")
        
        }catch {
            errorMessage = "Veri alınamadı. Lütfen şehir adını kontrol et."
        }
        
        isLoading = false
    }
    
    func translateDescription(_ english: String) -> String {
        switch english.lowercased() {
        case "clear sky": return "Açık"
        case "few clouds": return "Az bulutlu"
        case "overcast clouds": return "Kapalı bulutlu"
        case "scattered clouds": return "Parçalı bulutlu"
        case "broken clouds": return "Çok bulutlu"
        case "shower rain": return "Sağanak yağış"
        case "rain": return "Yağmurlu"
        case "thunderstorm": return "Gök gürültülü"
        case "snow": return "Karlı"
        case "mist": return "Sisli"
        default: return english.capitalized
        }
    }
    
    
}
