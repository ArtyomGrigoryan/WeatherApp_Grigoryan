//
//  LoadingView.swift
//  WeatherApp_Grigoryan
//
//  Created by Артём Григорян on 13.05.2025.
//

import UIKit

class LoadingView: UIView {
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    private let loadingLabel: UILabel = {
        let label = UILabel()
        label.text = "Загрузка данных погоды..."
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    private func setupViews() {
        backgroundColor = .systemBackground
                
        let stackView = UIStackView(arrangedSubviews: [activityIndicator, loadingLabel])
        stackView.spacing = 16
        stackView.axis = .vertical
        stackView.alignment = .center
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func startLoading() {
        activityIndicator.startAnimating()
        isHidden = false
    }
    
    func stopLoading() {
        activityIndicator.stopAnimating()
        isHidden = true
    }
}
