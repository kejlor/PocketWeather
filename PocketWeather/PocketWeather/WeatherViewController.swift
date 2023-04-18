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
    let searchTextField = SearchTextField(placeHolderText: "Enter city name")
    
    var weatherManager: WeatherManageable = WeatherManager()
    
    lazy var errorAlert: UIAlertController = {
        let alert =  UIAlertController(title: "", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alert
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        setupKeyboardHiding()
    }
    
    private func setupKeyboardHiding() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

extension WeatherViewController {
    func style() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .center
        
        weatherView.translatesAutoresizingMaskIntoConstraints = false
        weatherView.isHidden = true
        
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.delegate = self
        
        let gradient: CAGradientLayer = CAGradientLayer()
        
        gradient.colors = [UIColor.black.cgColor, UIColor.blue.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x : 0.0, y : 0)
        gradient.endPoint = CGPoint(x :0.0, y: 0.5) // you need to play with 0.15 to adjust gradient vertically
        gradient.frame = view.bounds
        
        view.layer.addSublayer(gradient)
    }
    
    func layout() {
        stackView.addArrangedSubview(weatherView)
        stackView.addArrangedSubview(searchTextField)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

// MARK: - Networking
extension WeatherViewController {
    private func fetchWeather(cityName: String) {
        weatherManager.fetchWeather(forCityName: cityName) { result in
            switch result {
            case .success(let weather):
                self.changeLabels(weather)
                self.weatherView.isHidden = false
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
            title = "Decoding Error"
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

// MARK: - SearchTextFieldDelegate
extension WeatherViewController: SearchTextFieldDelegate {
    func editingDidEnd(_ sender: SearchTextField) {
        fetchWeather(cityName: sender.textField.text ?? "")
    }
}

// MARK: - Actions
extension WeatherViewController {
    @objc func refreshContent() {
        reset()
    }
    
    private func reset() {
        weather = nil
    }
    
    private func changeLabels(_ weather: WeatherResult) {
        self.weather = weather
        self.weatherView.cityNameLabelView.label.text = weather.name
        self.weatherView.weatherType = WeatherType(rawValue: weather.weather[0].main) ?? .Clear
        self.weatherView.windLabelView.label.text = String(weather.wind.speed) + " km/h"
        self.weatherView.temperatureLabelView.label.text = String(weather.main.temp) + "°"
        self.weatherView.humidityLabelView.label.text = String(weather.main.humidity)
        self.weatherView.descriptionLabelView.label.text = weather.weather[0].description
        self.weatherView.weatherTextLabel.text = weather.weather[0].main
        self.weatherView.checkWeatherImage()
    }
}

// MARK: Keyboard
extension WeatherViewController {
    @objc func keyboardWillShow(sender: NSNotification) {
        guard let userInfo = sender.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextField = UIResponder.currentFirst() as? UITextField else { return }

        // check if the top of the keyboard is above the bottom of the currently focused textbox
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height

        // if textField bottom is below keyboard bottom - bump the frame up
        if textFieldBottomY > keyboardTopY {
            let textBoxY = convertedTextFieldFrame.origin.y
            let newFrameY = (textBoxY - keyboardTopY / 2) * -1
            view.frame.origin.y = newFrameY
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
}

// MARK: - Unit testing
extension WeatherViewController {
    func titleAndMessageForTesting(for error: NetworkError) -> (String, String) {
        return titleAndMessage(for: error)
    }
    
    func forceFetchWeather() {
        fetchWeather(cityName: "London")
    }
}
