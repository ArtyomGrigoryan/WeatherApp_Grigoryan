//
//  HourlyForecastView.swift
//  WeatherApp_Grigoryan
//
//  Created by Артём Григорян on 13.05.2025.
//

import UIKit

class HourlyForecastView: UIView {
    private var hourlyForecasts: [HourlyForecast] = []

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Почасовой прогноз погоды"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()

    private lazy var headerStackView: UIStackView = {
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(systemName: "clock")
        iconImageView.tintColor = .label
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.setContentHuggingPriority(.required, for: .horizontal)

        let stack = UIStackView(arrangedSubviews: [iconImageView, titleLabel])
        stack.spacing = 8
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fill
        return stack
    }()

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 58, height: 120)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(HourlyForecastCell.self, forCellWithReuseIdentifier: UIConstants.ReuseIdentifiers.HourlyForecastCellIdentifier)
        return collectionView
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

        collectionView.dataSource = self

        let stackView = UIStackView(arrangedSubviews: [headerStackView, collectionView])
        stackView.axis = .vertical
        stackView.spacing = 8

        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),

            collectionView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    func configure(with forecastDays: [ForecastDay]) {
        if !forecastDays.isEmpty {
            let currentHour = Calendar.current.component(.hour, from: Date())
            // Обработка сегодняшних часов
            let todayHours = forecastDays[0].hour.compactMap { hour -> HourlyForecast? in
                let hourValue = hour.time.hourValue
                guard hourValue >= currentHour else { return nil }
                let isCurrentHour = hourValue == currentHour
                
                return HourlyForecast(from: hour, isCurrentHour: isCurrentHour)
            }

            hourlyForecasts.append(contentsOf: todayHours)
            // Обработка завтрашних часов
            if forecastDays.count > 1 {
                let tomorrowHours = forecastDays[1].hour.map { hour in
                    HourlyForecast(from: hour, isCurrentHour: false)
                }
                
                hourlyForecasts.append(contentsOf: tomorrowHours)
            }
        }

        collectionView.reloadData()
    }
}

extension HourlyForecastView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourlyForecasts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UIConstants.ReuseIdentifiers.HourlyForecastCellIdentifier, for: indexPath) as! HourlyForecastCell
        cell.configure(with: hourlyForecasts[indexPath.item])
        return cell
    }
}
