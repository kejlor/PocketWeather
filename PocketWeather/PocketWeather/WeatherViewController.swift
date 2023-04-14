//
//  WeatherViewController.swift
//  PocketWeather
//
//  Created by Bartosz Wojtkowiak on 13/04/2023.
//

import UIKit

class WeatherViewController: UIViewController {
    
    var weather: WeatherResult?
    
    let stackView = UIStackView()
    let weatherView = WeatherView()
    let searchButton = UIButton()
    
    
    var weatherManager: WeatherManager = WeatherManager()
    
    lazy var errorAlert: UIAlertController = {
        let alert =  UIAlertController(title: "", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alert
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension WeatherViewController {
    func style() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.backgroundColor = .orange
        
        weatherView.translatesAutoresizingMaskIntoConstraints = false
        
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.configuration = .filled()
        searchButton.configuration?.imagePadding = 8
        searchButton.setTitle("Search", for: [])
        searchButton.addTarget(self, action: #selector(searchTapped), for: .primaryActionTriggered)
    }
    
    func layout() {
        stackView.addArrangedSubview(weatherView)
        stackView.addArrangedSubview(searchButton)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

// MARK: - Networking
extension WeatherViewController {
    private func fetchWeather(cityName: String) {
        // zmienic
        weatherManager.fetchWeather(forCityName: cityName) { result in
            switch result {
            case .success(let weather):
                self.weather = weather
                print(weather.main.temp)
                self.weatherView.cityNameLabel.text = weather.name
                self.weatherView.temperatureLabel.text = String(weather.main.temp)
            case .failure(let error):
                self.displayError(error)
            }
        }
    }
    
    private func displayError(_ error: NetworkError) {
        let titleAndMessage = titleAndMessage(for: error)
        self.showErrorAlert(title: titleAndMessage.0, message: titleAndMessage.1)
    }

    func titleAndMessage(for error: NetworkError) -> (String, String) {
        let title: String
        let message: String
        switch error {
        case .serverError:
            title = "Server Error"
            message = "We could not process your request. Please try again."
        case .decodingError:
            title = "Network Error"
            message = "Ensure you have provided correct city name. Please try again."
        }
        return (title, message)
    }
    
    private func showErrorAlert(title: String, message: String) {
        errorAlert.title = title
        errorAlert.message = message

        if !errorAlert.isBeingPresented {
            present(errorAlert, animated: true, completion: nil)
        }
    }
}

// MARK: - Actions
extension WeatherViewController {
    @objc func searchTapped(sender: UIButton) {
        fetchWeather(cityName: weatherView.cityNameTextField.text ?? "")
    }
    
    @objc func refreshContent() {
        reset()
    }
    
    private func reset() {
        weather = nil
    }
}
