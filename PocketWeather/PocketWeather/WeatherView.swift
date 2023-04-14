//
//  WeatherView.swift
//  PocketWeather
//
//  Created by Bartosz Wojtkowiak on 13/04/2023.
//

import UIKit

class WeatherView: UIView {
    
    let stackView = UIStackView()
    let cityNameLabel = UILabel()
    let temperatureLabel = UILabel()
    let cityNameTextField = UITextField()
    let searchButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 200)
    }
}

extension WeatherView {
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
    }
    
    func layout() {
        stackView.addArrangedSubview(cityNameLabel)
        stackView.addArrangedSubview(temperatureLabel)
        stackView.addArrangedSubview(cityNameTextField)
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}

extension WeatherView: UITextFieldDelegate {
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
