//
//  TableViewCell.swift
//  Recipely
//
//  Created by Виталий Горбунов on 29.02.2024.
//

import UIKit

class TableViewCell: UITableViewCell {
    // MARK: - Constants
    enum Constants {
        
    }
    
    // MARK: - Visual Components
    
    private var dishImageView = UIImageView()
    private var timerImageView = UIImageView(image: .timer)
    private var pizzaImageView = UIImageView(image: .pizza)
    
    
    private let namedishLabel = {
        let label = UILabel()
        label.font = .verdana?.withSize(14)
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let timetLabel = {
        let label = UILabel()
        label.font = .verdana?.withSize(12)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    private let caloriesLabel = {
        let label = UILabel()
        label.font = .verdana?.withSize(12)
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let arrowButton = {
        let button = UIButton()
        button.setImage(.vector, for: .normal)
        return button
    }()
    
    private let recipeView = {
        let view = UIView()
        view.backgroundColor = UIColor.recipeView
        view.layer.cornerRadius = 12
        return view
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
//        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Private Methods

    private func setupUI() {
        contentView.addSubviews(recipeView, namedishLabel, timetLabel, caloriesLabel, arrowButton, dishImageView, timerImageView, pizzaImageView)
    }
    
    private func configureLayout() {
        UIView.doNotTAMIC(for: recipeView, namedishLabel, timetLabel, caloriesLabel, arrowButton, dishImageView, timerImageView, pizzaImageView)
//        configureImageViewLayout()
//        configureBottonLayout()
        configureLabelLayout()
        configureViewLayout()
    }
    
    private func configureViewLayout() {
        [
            recipeView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            recipeView.heightAnchor.constraint(equalToConstant: 100),
            recipeView.widthAnchor.constraint(equalToConstant: 350),
            recipeView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ].activate()
    }
    
    private func configureLabelLayout() {
        [
            namedishLabel.leadingAnchor.constraint(equalTo: dishImageView.trailingAnchor, constant: 20),
            namedishLabel.topAnchor.constraint(equalTo: dishImageView.topAnchor, constant: 121),
            namedishLabel.widthAnchor.constraint(equalToConstant: 197),
            namedishLabel.heightAnchor.constraint(equalToConstant: 32),
        
            timetLabel.leadingAnchor.constraint(equalTo: timerImageView.trailingAnchor, constant: 5.88),
            timetLabel.topAnchor.constraint(equalTo: namedishLabel.bottomAnchor, constant: 8),
            timetLabel.widthAnchor.constraint(equalToConstant: 55),
            timetLabel.heightAnchor.constraint(equalToConstant: 15),
        
//            caloriesLabel.leadingAnchor.constraint(equalTo: pizzaImageView.trailingAnchor, e),
//            caloriesLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            caloriesLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            caloriesLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        
        
        ].activate()
    }
}
