//
//  WeatherTests.swift
//  PocketWeatherUnitTests
//
//  Created by Bartosz Wojtkowiak on 18/04/2023.
//

import Foundation
import XCTest

@testable import PocketWeather

class WeatherTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testCanParse() throws {
        let json = """
        {
          "weather": [
            {
              "main": "Clouds",
              "description": "overcast clouds",
            }
          ],
          "main": {
            "temp": 12,
            "humidity": 77,
          },
          "wind": {
            "speed": 5.7,
          },
          "name": "Berlin",
        }
        """
        
        let data = json.data(using: .utf8)!
        let decoder = JSONDecoder()
        
        let result = try decoder.decode(WeatherResult.self, from: data)
        
        XCTAssertEqual(result.main.humidity, 77)
        XCTAssertEqual(result.main.temp, 12)
        XCTAssertEqual(result.weather[0].description, "overcast clouds")
        XCTAssertEqual(result.weather[0].main, "Clouds")
        XCTAssertEqual(result.wind.speed, 5.7)
        XCTAssertEqual(result.name, "Berlin")
    }
}
