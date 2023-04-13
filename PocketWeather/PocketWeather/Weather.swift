//
//  Weather.swift
//  PocketWeather
//
//  Created by Bartosz Wojtkowiak on 13/04/2023.
//

import Foundation

struct WeatherResult: Decodable {
    let main: Weather
    let name: String
}

struct Weather: Decodable {
    let temp: Double
}
