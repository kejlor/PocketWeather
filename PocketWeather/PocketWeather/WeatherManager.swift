//
//  WeatherManager.swift
//  PocketWeather
//
//  Created by Bartosz Wojtkowiak on 13/04/2023.
//

import Foundation

protocol WeatherManageable: AnyObject {
    func fetchWeather(forCityName: String, completion: @escaping (Result<WeatherResult,NetworkError>) -> Void)
}

enum NetworkError: Error {
    case serverError
    case decodingError
}

class WeatherManager: WeatherManageable {
    func fetchWeather(forCityName cityName: String, completion: @escaping (Result<WeatherResult, NetworkError>) -> Void) {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(ENV.SERVICE_API_KEY)&units=metric")!
        
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completion(.failure(.serverError))
                    return
                }

                do {
                    let weather = try JSONDecoder().decode(WeatherResult.self, from: data)
                    completion(.success(weather))
                } catch {
                    completion(.failure(.decodingError))
                }
            }
        }.resume()
    }
}
