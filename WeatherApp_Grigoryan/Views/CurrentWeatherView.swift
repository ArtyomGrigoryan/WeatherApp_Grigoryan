//
//  CurrentWeatherView.swift
//  WeatherApp_Grigoryan
//
//  Created by Артём Григорян on 13.05.2025.
//

import UIKit

class CurrentWeatherView: UIView {
    private let weatherService = WeatherDataFetcher()
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .medium)
        return label
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 48, weight: .medium)
        return label
    }()

    private let conditionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    private let tempRangeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    private func setupViews() {
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 12
        //clipsToBounds = true
                
        let contentStack = UIStackView(arrangedSubviews: [
            cityLabel,
            temperatureLabel,
            UIStackView(arrangedSubviews: [conditionLabel, iconImageView]),
            tempRangeLabel
        ])
        
        contentStack.spacing = 8
        contentStack.axis = .vertical
        contentStack.alignment = .center
        
        addSubview(contentStack)
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            contentStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            contentStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            contentStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            
            iconImageView.widthAnchor.constraint(equalToConstant: 40),
            iconImageView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @MainActor
    func configure(with weatherData: WeatherData) {
        cityLabel.text = weatherData.fullLocationString
        temperatureLabel.text = weatherData.currentTempCString
        conditionLabel.text = weatherData.current.condition.localizedDescription
        tempRangeLabel.text = weatherData.tempRangeString
        
        Task {
            let data = try await weatherService.fetchWeatherIcon(with: weatherData.current.condition.icon)
            iconImageView.image = UIImage(data: data)
        }
    }
}
