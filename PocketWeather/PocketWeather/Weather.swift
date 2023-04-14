//
//  Weather.swift
//  PocketWeather
//
//  Created by Bartosz Wojtkowiak on 13/04/2023.
//

import Foundation

struct WeatherResult: Decodable {
    let main: Temperature
    let name: String
    let weather: [Weather]
    let wind: Wind
}

struct Temperature: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let main: String
}

struct Wind: Decodable {
    let speed: Double
}
