//
//  DailyForecastCell.swift
//  WeatherApp_Grigoryan
//
//  Created by Артём Григорян on 13.05.2025.
//

import UIKit

class DailyForecastCell: UITableViewCell {
    private let weatherService = WeatherDataFetcher()
    
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let highTempLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private let lowTempLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .secondaryLabel
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    private func setupViews() {
        selectionStyle = .none
        backgroundColor = .clear
        
        let tempStack = UIStackView(arrangedSubviews: [lowTempLabel, highTempLabel])
        tempStack.axis = .horizontal
        tempStack.spacing = 8
        
        let stackView = UIStackView(arrangedSubviews: [dayLabel, iconImageView, tempStack])
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.spacing = 16
        
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            iconImageView.widthAnchor.constraint(equalToConstant: 32),
            iconImageView.heightAnchor.constraint(equalToConstant: 32),
            
            dayLabel.widthAnchor.constraint(equalToConstant: 66)
        ])
    }

    @MainActor
    func configure(with forecast: DailyForecast) {
        dayLabel.text = forecast.dayOfWeek
        lowTempLabel.text = forecast.minTempString
        highTempLabel.text = forecast.maxTempString

        Task {
            let data = try await weatherService.fetchWeatherIcon(with: forecast.day.condition.icon)
            iconImageView.image = UIImage(data: data)
        }
    }
}
