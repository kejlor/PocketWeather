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
//    let image = UIImage()
    let weatherNameLabel = UILabel()
    let windLabel = UILabel()
    let temperatureLabel = UILabel()
    
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
        
        weatherNameLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherNameLabel.text = ""
        weatherNameLabel.textAlignment = .center
        
        windLabel.translatesAutoresizingMaskIntoConstraints = false
        windLabel.text = ""
        windLabel.textAlignment = .center
    }
    
    func layout() {
        stackView.addArrangedSubview(cityNameLabel)
        stackView.addArrangedSubview(temperatureLabel)
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
