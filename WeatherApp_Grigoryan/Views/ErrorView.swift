//
//  ErrorView.swift
//  WeatherApp_Grigoryan
//
//  Created by Артём Григорян on 13.05.2025.
//

import UIKit

class ErrorView: UIView {
    var retryAction: (() -> Void)?
    
    var errorText: String? {
        get { errorLabel.text }
        set { errorLabel.text = newValue ?? "Не получилось загрузить данные погоды" }
    }
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let retryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Повторить", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        return button
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

        retryButton.addTarget(self, action: #selector(retryTouched), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [errorLabel, retryButton])
        stackView.spacing = 16
        stackView.axis = .vertical
        stackView.alignment = .center
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
        ])
    }
    
    @objc private func retryTouched() {
        retryAction?()
    }
}
