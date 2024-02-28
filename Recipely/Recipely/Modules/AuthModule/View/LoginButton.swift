//
//  LoginButton.swift
//  Recipely
//
//  Created by Tixon Markin on 28.02.2024.
//

import UIKit

final class LoginButton: UIButton {
    
    // MARK: - Visual Components
    
    private var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
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
        activityIndicator.startAnimating()
    }
    
    func stopIndicator() {
        setTitle(title, for: .normal)
        activityIndicator.stopAnimating()
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        backgroundColor = .black
        layer.cornerRadius = 12
        setTitleColor(.white, for: .normal)
        titleLabel?.font = .verdanaBold?.withSize(16)
    }
    
    private func configureLayout() {
        UIView.doNotTAMIC(for: activityIndicator)
        [
            activityIndicator.topAnchor.constraint(equalTo: topAnchor, constant: 14),
            activityIndicator.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -14),
            activityIndicator.widthAnchor.constraint(equalTo: activityIndicator.heightAnchor)
        ].activate()
    }
}


