//
//  MainView.swift
//  WeatherApp
//
//  Created by Mesut As on 29.05.2025.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var viewModel = WeatherViewModel()
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 30) {
                    Image("logo")
                        .resizable()
                        .frame(width: 200, height: 100)
                        .padding(.top, 20)

                    TextField("Şehir Girin", text: $viewModel.city)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)

                    Button("Hava Durumunu Göster") {
                        Task {
                            await viewModel.fetchWeather()
                        }
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)

                    if viewModel.isLoading {
                        ProgressView("Yükleniyor..")
                    }

                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                    }

                    if !viewModel.temperature.isEmpty {
                        VStack(spacing: 10) {
                            Text(viewModel.cityName)
                                .font(.title)
                                .bold()

                            if let iconURL = viewModel.iconURL {
                                AsyncImage(url: iconURL) { image in
                                    image
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                } placeholder: {
                                    ProgressView()
                                }
                            }

                            Text(viewModel.temperature)
                                .font(.largeTitle)

                            Text(viewModel.description.capitalized)
                                .italic()
                        }
                        .padding()
                    }

                    Spacer()
                }
                .frame(maxWidth: .infinity)
            }
            .navigationTitle("Hava Durumu")
        }
    }
}

#Preview {
    MainView()
}
