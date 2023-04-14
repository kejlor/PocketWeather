//
//  WeatherView.swift
//  PocketWeather
//
//  Created by Bartosz Wojtkowiak on 13/04/2023.
//

import UIKit

class WeatherView: UIView {
    
    let stackView = UIStackView()
    let weatherImage = UIImageView()
    let weatherTextLabel = UILabel()
    let cityNameLabelView = WeatherLabelView(icon: "mappin")
    let windLabelView = WeatherLabelView(icon: "wind")
    let temperatureLabelView = WeatherLabelView(icon: "thermometer.high")
    let descriptionLabelView = WeatherLabelView(icon: "doc.plaintext")
    let humidityLabelView = WeatherLabelView(icon: "humidity.fill")
    
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
        stackView.backgroundColor = .orange
        
        weatherTextLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherTextLabel.text = "Sunny"
        weatherTextLabel.textAlignment = .center
        
        weatherImage.translatesAutoresizingMaskIntoConstraints = false
        weatherImage.contentMode = .scaleAspectFit
        
        cityNameLabelView.translatesAutoresizingMaskIntoConstraints = false
        windLabelView.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabelView.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabelView.translatesAutoresizingMaskIntoConstraints = false
        humidityLabelView.translatesAutoresizingMaskIntoConstraints = false
        
        checkWeatherImage()
    }
    
    func layout() {
        stackView.addArrangedSubview(cityNameLabelView)
        stackView.addArrangedSubview(weatherImage)
        stackView.addArrangedSubview(weatherTextLabel)
        stackView.addArrangedSubview(descriptionLabelView)
        stackView.addArrangedSubview(temperatureLabelView)
        stackView.addArrangedSubview(humidityLabelView)
        stackView.addArrangedSubview(windLabelView)
        
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
            weatherImage.image = UIImage(systemName: "cloud.bolt.rain.fill")
        case .Drizzle:
            weatherImage.image = UIImage(systemName: "cloud.drizzle.fill")
        case .Rain:
            weatherImage.image = UIImage(systemName: "cloud.rain.fill")
        case .Snow:
            weatherImage.image = UIImage(systemName: "cloud.snow.fill")
        case .Mist:
            weatherImage.image = UIImage(systemName: "cloud.snow.fill")
        case .Smoke:
            weatherImage.image = UIImage(systemName: "smoke.fill")
        case .Haze:
            weatherImage.image = UIImage(systemName: "sun.haze.fill")
        case .Dust:
            weatherImage.image = UIImage(systemName: "sun.dust.fill")
        case .Fog:
            weatherImage.image = UIImage(systemName: "cloud.fog.fill")
        case .Sand:
            weatherImage.image = UIImage(systemName: "icloud.slash.fill")
        case .Ash:
            weatherImage.image = UIImage(systemName: "icloud.slash.fill")
        case .Squall:
            weatherImage.image = UIImage(systemName: "icloud.slash.fill")
        case .Tornado:
            weatherImage.image = UIImage(systemName: "tornado")
        case .Clear:
            weatherImage.image = UIImage(systemName: "sun.max.fill")
        case .Clouds:
            weatherImage.image = UIImage(systemName: "cloud.fill")
        }
    }
}
