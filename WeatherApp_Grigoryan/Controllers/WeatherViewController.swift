//
//  WeatherViewController.swift
//  WeatherApp_Grigoryan
//
//  Created by Артём Григорян on 13.05.2025.
//

import UIKit

class WeatherViewController: UIViewController {
    private let weatherView = WeatherView()
    private let locationService = LocationService()
    private let weatherService = WeatherDataFetcher()
    private let locationProvider = LocationProvider()
    private var location: LocationCoordinate! // По условию задачи, если нет текущих координат, то должна возвращаться Москва
    private var isFetching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupObservers()
        setupView()
        
        fetchLocationAndForecast()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(weatherView)
        
        weatherView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherView.topAnchor.constraint(equalTo: view.topAnchor),
            weatherView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            weatherView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            weatherView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // Позволит не выгружая приложение из памяти обновить геолокацию (если свернуть приложение и зайти в "Настройки" и дать доступ к геолокации, если оно не было дано ранее)
    @MainActor
    private func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(appWillEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        locationService.observeAuthorizationChanges { [weak self] isAuthorized in
            guard let self = self, isAuthorized, !self.isFetching else { return }
            self.fetchLocationAndForecast()
        }
    }
    
    @objc private func appWillEnterForeground() {
        if locationService.isAuthorized() {
            fetchLocationAndForecast()
        }
    }
    
    private func fetchLocationAndForecast() {
        guard !isFetching else { return }
        isFetching = true
        
        Task {
            await fetchLocation()
            await fetchForecast()
            isFetching = false
        }
    }
    
    private func fetchLocation() async {
        location = await locationProvider.fetchLocation()
    }
    
    @MainActor
    private func fetchForecast() async {
        weatherView.showLoadingView()

        do {
            let weatherData = try await weatherService.fetchWeatherData(from: location)
            
            weatherView.configure(with: weatherData)
            weatherView.showContent()
        } catch {
            weatherView.showErrorView(errorMessage: error.localizedDescription) { [weak self] in
                Task {
                    guard let self = self else { return }
                    await self.fetchForecast()
                }
            }
        }
    }
}
