// ActivityButton.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Кнопка с возможностью запустить  активити индикатор
final class ActivityButton: UIButton {
    // MARK: - Visual Components

    private var activityIndicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        indicator.color = .white
        return indicator
    }()

    // MARK: - Private Properties

    private var title: String?

    // MARK: - Initializers

    init() {
        super.init(frame: .zero)
        configureUI()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
        configureLayout()
    }

    // MARK: - Public Methods

    func startIndicator() {
        title = titleLabel?.text
        setTitle("", for: .normal)
        activityIndicatorView.startAnimating()
    }

    func stopIndicator() {
        setTitle(title, for: .normal)
        activityIndicatorView.stopAnimating()
    }

    // MARK: - Private Methods

    private func configureUI() {
        addSubviews(activityIndicatorView)
        backgroundColor = .black
        layer.cornerRadius = 12
        setTitleColor(.white, for: .normal)
        titleLabel?.font = .verdanaBold(size: 16)
    }

    private func configureLayout() {
        UIView.doNotTAMIC(for: activityIndicatorView)
        [
            activityIndicatorView.topAnchor.constraint(equalTo: topAnchor, constant: 14),
            activityIndicatorView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -14),
            activityIndicatorView.widthAnchor.constraint(equalTo: activityIndicatorView.heightAnchor),
            activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ].activate()
    }
}
