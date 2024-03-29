// SettingsFieldCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка содержащая настройку
final class SettingsFieldCell: UITableViewCell {
    // MARK: - Visual Components

    private let iconImageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .center
        view.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
        view.layer.cornerRadius = 12
        return view
    }()

    private let captionLabel: UILabel = {
        let label = UILabel()
        label.font = .verdana(size: 18)
        label.textColor = .textAccent
        label.textAlignment = .left
        return label
    }()

    private let accessoryImageView: UIImageView = {
        let view = UIImageView()
        view.image = AssetImage.Icons.rigthBracket.image.withRenderingMode(.alwaysOriginal)
        view.contentMode = .center
        view.clipsToBounds = true
        return view
    }()

    private let bottomSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .opaqueSeparator
        return view
    }()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
        configureLayout()
    }

    // MARK: - Public Methods

    func configure(with setting: Setting) {
        selectionStyle = .none
        iconImageView.image = ImageAsset(name: setting.icon).image.withTintColor(
            .accent,
            renderingMode: .alwaysOriginal
        )
        captionLabel.text = setting.name
    }

    // MARK: - Private Methods

    private func configureUI() {
        contentView.addSubviews(iconImageView, captionLabel, accessoryImageView, bottomSeparatorView)
    }

    private func configureLayout() {
        UIView.doNotTAMIC(for: iconImageView, captionLabel, accessoryImageView, bottomSeparatorView)
        configureIconImageViewLayout()
        configureCaptionLabelLayout()
        configureAccessoryImageViewLayout()
        configureBottomSeparatorLayout()
    }

    private func configureIconImageViewLayout() {
        [
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            iconImageView.heightAnchor.constraint(equalToConstant: 48),
            iconImageView.widthAnchor.constraint(equalTo: iconImageView.heightAnchor)
        ].activate()
    }

    private func configureCaptionLabelLayout() {
        [
            captionLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16),
            captionLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
        ].activate()
    }

    private func configureAccessoryImageViewLayout() {
        [
            accessoryImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            accessoryImageView.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
            accessoryImageView.heightAnchor.constraint(equalToConstant: 24),
            accessoryImageView.widthAnchor.constraint(equalTo: accessoryImageView.heightAnchor)
        ].activate()
    }

    private func configureBottomSeparatorLayout() {
        [
            bottomSeparatorView.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 4),
            bottomSeparatorView.leadingAnchor.constraint(equalTo: captionLabel.leadingAnchor),
            bottomSeparatorView.trailingAnchor.constraint(equalTo: accessoryImageView.leadingAnchor),
            bottomSeparatorView.heightAnchor.constraint(equalToConstant: 1),
            bottomSeparatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ].activate()
    }
}
