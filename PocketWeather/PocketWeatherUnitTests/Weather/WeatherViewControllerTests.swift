//
//  WeatherViewControllerTests.swift
//  PocketWeatherUnitTests
//
//  Created by Bartosz Wojtkowiak on 18/04/2023.
//

import Foundation
import XCTest

@testable import PocketWeather

class WeatherViewControllerTests: XCTestCase {
    var vc: WeatherViewController!
    var mockManager: MockWeatherManager!
    
    class MockWeatherManager: WeatherManageable {
        var weather: WeatherResult?
        var error: NetworkError?
        
        func fetchWeather(forCityName: String, completion: @escaping (Result<WeatherResult, NetworkError>) -> Void) {
            if error != nil {
                completion(.failure(error!))
                return
            }
            weather = WeatherResult(main: Temperature(temp: 12, humidity: 77), name: "London", weather: [Weather(main: "Clouds", description: "cloudy weather")], wind: Wind(speed: 6))
        }
    }
    
    override func setUp() {
        super.setUp()
        vc = WeatherViewController()
        
        mockManager = MockWeatherManager()
        vc.weatherManager = mockManager
    }
    
    func testTitleAndMessageForServerError() throws {
        let titleAndMessage = vc.titleAndMessage(for: .serverError)
        XCTAssertEqual(titleAndMessage.0, "Server Error")
        XCTAssertEqual(titleAndMessage.1, "We could not process your request. Please try again.")
    }
    
    func testTitleAndMessageForDecodingError() throws {
        let titleAndMessage = vc.titleAndMessage(for: .decodingError)
        XCTAssertEqual(titleAndMessage.0, "Decoding Error")
        XCTAssertEqual(titleAndMessage.1, "Ensure you have provided correct city name. Please try again.")
    }
    
    func testAlertForServerError() throws {
        mockManager.error = NetworkError.serverError
        vc.forceFetchWeather()
        
        XCTAssertTrue(vc.errorAlert.title!.contains("Server"))
        XCTAssertTrue(vc.errorAlert.message!.contains("process your request"))
    }
    
    func testAlertForDecodingError() throws {
        mockManager.error = NetworkError.decodingError
        vc.forceFetchWeather()
        
        XCTAssertTrue(vc.errorAlert.title!.contains("Decoding"))
        XCTAssertTrue(vc.errorAlert.message!.contains("Ensure you have provided correct city name"))
    }
}
