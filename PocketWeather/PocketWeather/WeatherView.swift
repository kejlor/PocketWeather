//
//  WeatherView.swift
//  PocketWeather
//
//  Created by Bartosz Wojtkowiak on 13/04/2023.
//

import UIKit

class WeatherView: UIView {
    
    let stackView = UIStackView()
    let centerStackView = UIStackView()
    let horizontalStackView = UIStackView()
    let weatherImage = UIImageView()
    let weatherTextLabel = UILabel()
    let cityNameLabelView = WeatherLabelView(icon: "mappin", fontSize: 50, plainText: "Leszno")
    let windLabelView = WeatherLabelView(icon: "wind", plainText: "20 km/h")
    let temperatureLabelView = WeatherLabelView(icon: "thermometer.high", fontSize: 50, plainText: "30°")
    let descriptionLabelView = WeatherLabelView(icon: "doc.plaintext", plainText: "Sunny")
    let humidityLabelView = WeatherLabelView(icon: "humidity.fill", plainText: "74")
    let configuration = UIImage.SymbolConfiguration(pointSize: 150)
    
    var weatherType: WeatherType = .Clear
    
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
        stackView.alignment = .center
        
        centerStackView.translatesAutoresizingMaskIntoConstraints = false
        centerStackView.axis = .vertical
        centerStackView.spacing = 20
        centerStackView.alignment = .center
        
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .fill
        horizontalStackView.spacing = 30
        
        weatherTextLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherTextLabel.text = "Sunny"
        weatherTextLabel.textAlignment = .center
        weatherTextLabel.textColor = .white
        weatherTextLabel.shadowColor = .black
        weatherTextLabel.font = weatherTextLabel.font.withSize(30)
        
        
        weatherImage.translatesAutoresizingMaskIntoConstraints = false
        weatherImage.contentMode = .scaleAspectFit
        
        cityNameLabelView.translatesAutoresizingMaskIntoConstraints = false
        cityNameLabelView.label.font = UIFont.boldSystemFont(ofSize: cityNameLabelView.label.font.pointSize)
        
        windLabelView.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabelView.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabelView.translatesAutoresizingMaskIntoConstraints = false
        humidityLabelView.translatesAutoresizingMaskIntoConstraints = false
        
        checkWeatherImage()
    }
    
    func layout() {
        centerStackView.addArrangedSubview(cityNameLabelView)
        centerStackView.addArrangedSubview(weatherImage)
        centerStackView.addArrangedSubview(weatherTextLabel)
        centerStackView.addArrangedSubview(descriptionLabelView)
        centerStackView.addArrangedSubview(temperatureLabelView)
        
        horizontalStackView.addArrangedSubview(humidityLabelView)
        horizontalStackView.addArrangedSubview(windLabelView)
        
        stackView.addArrangedSubview(centerStackView)
        stackView.addArrangedSubview(horizontalStackView)
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2),
            bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 2)
        ])
        
        // CHCR
        weatherImage.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .vertical)
    }
}

extension WeatherView {
    func checkWeatherImage() {
        switch weatherType {
        case .Thunderstorm:
            weatherImage.image = UIImage(systemName: "cloud.bolt.rain.fill", withConfiguration: configuration)?.withTintColor(.white, renderingMode: .alwaysOriginal)
        case .Drizzle:
            weatherImage.image = UIImage(systemName: "cloud.drizzle.fill", withConfiguration: configuration)?.withTintColor(.white, renderingMode: .alwaysOriginal)
        case .Rain:
            weatherImage.image = UIImage(systemName: "cloud.rain.fill", withConfiguration: configuration)?.withTintColor(.white, renderingMode: .alwaysOriginal)
        case .Snow:
            weatherImage.image = UIImage(systemName: "cloud.snow.fill", withConfiguration: configuration)?.withTintColor(.white, renderingMode: .alwaysOriginal)
        case .Mist:
            weatherImage.image = UIImage(systemName: "cloud.snow.fill", withConfiguration: configuration)?.withTintColor(.white, renderingMode: .alwaysOriginal)
        case .Smoke:
            weatherImage.image = UIImage(systemName: "smoke.fill", withConfiguration: configuration)?.withTintColor(.white, renderingMode: .alwaysOriginal)
        case .Haze:
            weatherImage.image = UIImage(systemName: "sun.haze.fill", withConfiguration: configuration)?.withTintColor(.white, renderingMode: .alwaysOriginal)
        case .Dust:
            weatherImage.image = UIImage(systemName: "sun.dust.fill", withConfiguration: configuration)?.withTintColor(.white, renderingMode: .alwaysOriginal)
        case .Fog:
            weatherImage.image = UIImage(systemName: "cloud.fog.fill", withConfiguration: configuration)?.withTintColor(.white, renderingMode: .alwaysOriginal)
        case .Sand:
            weatherImage.image = UIImage(systemName: "icloud.slash.fill", withConfiguration: configuration)?.withTintColor(.white, renderingMode: .alwaysOriginal)
        case .Ash:
            weatherImage.image = UIImage(systemName: "icloud.slash.fill", withConfiguration: configuration)?.withTintColor(.white, renderingMode: .alwaysOriginal)
        case .Squall:
            weatherImage.image = UIImage(systemName: "icloud.slash.fill", withConfiguration: configuration)?.withTintColor(.white, renderingMode: .alwaysOriginal)
        case .Tornado:
            weatherImage.image = UIImage(systemName: "tornado", withConfiguration: configuration)?.withTintColor(.white, renderingMode: .alwaysOriginal)
        case .Clear:
            weatherImage.image = UIImage(systemName: "sun.max.fill", withConfiguration: configuration)?.withTintColor(.white, renderingMode: .alwaysOriginal)
        case .Clouds:
            weatherImage.image = UIImage(systemName: "cloud.fill", withConfiguration: configuration)?.withTintColor(.white, renderingMode: .alwaysOriginal)
        }
    }
}
