// SortControl.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол определяющий методы делега SortControl
protocol SortControlDelegate: AnyObject {
    /// Вызывается при каждом изменении переменной sortState, и сообщает о ее новом значении
    func sotingControl(_ control: SortControl, changedStateTo state: SortState)
}

/// Вью для отображения контрола сортировок
class SortControl: UIControl {
    // MARK: - Visual Components

    private let sortIconImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()

    private let captionLabel = {
        let label = UILabel()
        label.font = .verdana(size: 16)
        label.textAlignment = .right
        label.textColor = .black
        return label
    }()

    // MARK: - Public Properties

    weak var delegate: SortControlDelegate?

    // MARK: - Private Properties

    private(set) var sortState: SortState = .none {
        willSet(newState) {
            switchTo(state: newState)
            delegate?.sotingControl(self, changedStateTo: newState)
        }
    }

    // MARK: - Initializers

    init(title: String, state: SortState) {
        super.init(frame: .zero)
        configureView()
        configureLayout()
        configure(title: title, state: sortState)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
        configureLayout()
    }

    // MARK: - Private Methods

    private func configureView() {
        backgroundColor = .recipeView
        layer.cornerRadius = 18
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(controlTapped))
        addGestureRecognizer(tapGesture)
        addSubviews(sortIconImageView, captionLabel)
    }

    private func configureLayout() {
        UIView.doNotTAMIC(for: sortIconImageView, captionLabel)
        [
            captionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            captionLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

            sortIconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            sortIconImageView.leadingAnchor.constraint(equalTo: captionLabel.trailingAnchor, constant: 4),
            sortIconImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14),
            sortIconImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            sortIconImageView.heightAnchor.constraint(equalToConstant: 16),
            sortIconImageView.widthAnchor.constraint(equalTo: sortIconImageView.heightAnchor)
        ].activate()
    }

    private func switchTo(state: SortState) {
        switch state {
        case .none:
            backgroundColor = .recipeView
            sortIconImageView.image = .stackIcon
        case .accending:
            backgroundColor = .accent
            sortIconImageView.image = .stackIcon.withTintColor(.white)
        case .deccending:
            guard let image = UIImage.stackIcon.cgImage else { return }
            let downMirroredImage = UIImage(cgImage: image, scale: 1, orientation: .downMirrored).withTintColor(.white)
            backgroundColor = .accent
            sortIconImageView.image = downMirroredImage
        }
    }

    private func configure(title: String, state: SortState) {
        captionLabel.text = title
        sortState = state
    }

    @objc private func controlTapped() {
        sortState = sortState.next
    }
}
