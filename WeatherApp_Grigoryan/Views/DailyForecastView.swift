//
//  DailyForecastView.swift
//  WeatherApp_Grigoryan
//
//  Created by Артём Григорян on 13.05.2025.
//

import UIKit

class DailyForecastView: UIView {
    private var dailyForecasts: [DailyForecast] = []

    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .label
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "calendar")
        imageView.setContentHuggingPriority(.required, for: .horizontal)
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Прогноз погоды на 7 дней"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    private lazy var headerStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [iconImageView, titleLabel])
        stack.spacing = 8
        stack.axis = .horizontal
        stack.alignment = .center
        return stack
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.contentInset = .zero
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.estimatedRowHeight = 48
        tableView.backgroundColor = .clear
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(DailyForecastCell.self, forCellReuseIdentifier: UIConstants.ReuseIdentifiers.DailyForecastCellIdentifier)
        return tableView
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
        
        tableView.dataSource = self
        
        let stackView = UIStackView(arrangedSubviews: [headerStackView, tableView])
        stackView.axis = .vertical
        stackView.spacing = 8
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])
    }
    
    private func calculateConstraints() {
        layoutIfNeeded()
        
        let tableHeight = tableView.contentSize.height
        tableView.heightAnchor.constraint(equalToConstant: tableHeight).isActive = true
        
        let titleHeight = titleLabel.intrinsicContentSize.height
        let totalHeight = ceil(12 + titleHeight + 8 + tableHeight + 12)
        heightAnchor.constraint(equalToConstant: totalHeight).isActive = true
    }
    
    func configure(with forecastDays: [ForecastDay]) {
        dailyForecasts = forecastDays.map { DailyForecast(from: $0) }
        tableView.reloadData()
        calculateConstraints()
    }
}

extension DailyForecastView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyForecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UIConstants.ReuseIdentifiers.DailyForecastCellIdentifier, for: indexPath) as! DailyForecastCell
        cell.configure(with: dailyForecasts[indexPath.row])
        return cell
    }
}
