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
//    let image
    let cityNameLabel = UILabel()
    let temperatureLabel = UILabel()
    let cityNameTextField = UITextField()
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
        
        cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        cityNameLabel.text = ""
        cityNameLabel.textAlignment = .center
        cityNameLabel.numberOfLines = 0
        
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.text = ""
        temperatureLabel.textAlignment = .center
        
        cityNameTextField.translatesAutoresizingMaskIntoConstraints = false
        cityNameTextField.placeholder = "Enter city name"
        cityNameTextField.textAlignment = .center
        cityNameTextField.delegate = self
        
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.configuration = .filled()
        searchButton.configuration?.imagePadding = 8
        searchButton.setTitle("Search", for: [])
        searchButton.addTarget(self, action: #selector(searchTapped), for: .primaryActionTriggered)
    }
    
    func layout() {
        stackView.addArrangedSubview(cityNameLabel)
        stackView.addArrangedSubview(temperatureLabel)
        stackView.addArrangedSubview(cityNameTextField)
        stackView.addArrangedSubview(searchButton)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

// MARK: - UITextFieldDelegate
extension WeatherViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        cityNameTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
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
                self.cityNameLabel.text = weather.name
                self.temperatureLabel.text = String(weather.main.temp)
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

        // Don't present one error if another has already been presented
        if !errorAlert.isBeingPresented {
            present(errorAlert, animated: true, completion: nil)
        }
    }
}

// MARK: - Actions
extension WeatherViewController {
    @objc func searchTapped(sender: UIButton) {
        fetchWeather(cityName: cityNameTextField.text ?? "")
    }
    
    @objc func refreshContent() {
        reset()
    }
    
    private func reset() {
        weather = nil
    }
}
