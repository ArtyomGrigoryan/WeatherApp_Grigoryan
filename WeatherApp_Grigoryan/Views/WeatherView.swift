//
//  WeatherView.swift
//  WeatherApp_Grigoryan
//
//  Created by Артём Григорян on 13.05.2025.
//

import UIKit

class WeatherView: UIView {
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let currentWeatherView = CurrentWeatherView()
    private let hourlyForecastView = HourlyForecastView()
    private let dailyForecastView = DailyForecastView()
    
    private let loadingView = LoadingView()
    private let errorView = ErrorView()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    private func setupViews() {
        backgroundColor = .systemTeal
           
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(currentWeatherView)
        contentView.addSubview(hourlyForecastView)
        contentView.addSubview(dailyForecastView)

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
           
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
           
        currentWeatherView.translatesAutoresizingMaskIntoConstraints = false
        hourlyForecastView.translatesAutoresizingMaskIntoConstraints = false
        dailyForecastView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            currentWeatherView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            currentWeatherView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            currentWeatherView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
               
            hourlyForecastView.topAnchor.constraint(equalTo: currentWeatherView.bottomAnchor, constant: 20),
            hourlyForecastView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            hourlyForecastView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
               
            dailyForecastView.topAnchor.constraint(equalTo: hourlyForecastView.bottomAnchor, constant: 20),
            dailyForecastView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            dailyForecastView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            dailyForecastView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
           
        addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
           
        addSubview(errorView)
        errorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errorView.topAnchor.constraint(equalTo: topAnchor),
            errorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            errorView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
           
        loadingView.isHidden = true
        errorView.isHidden = true
    }
   
    func configure(with weatherData: WeatherData) {
        currentWeatherView.configure(with: weatherData)
        hourlyForecastView.configure(with: weatherData.forecast?.forecastday ?? [])
        dailyForecastView.configure(with: weatherData.forecast?.forecastday ?? [])
        
        layoutIfNeeded()
    }
    
    func showLoadingView() {
        loadingView.startLoading()
        errorView.isHidden = true
        scrollView.isHidden = true
    }
    
    func showContent() {
        loadingView.stopLoading()
        errorView.isHidden = true
        scrollView.isHidden = false
    }
    
    func showErrorView(errorMessage: String? = nil, retryAction: @escaping () -> Void) {
        loadingView.stopLoading()
        scrollView.isHidden = true
        errorView.isHidden = false
        errorView.errorText = errorMessage
        errorView.retryAction = retryAction
    }
}
