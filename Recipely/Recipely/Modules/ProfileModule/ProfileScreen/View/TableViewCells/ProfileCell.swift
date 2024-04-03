// ProfileCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка содержищая информацию о пользователе
final class ProfileCell: UITableViewCell {
    // MARK: - Visual Components

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .verdanaBold(size: 25)
        label.textColor = .textAccent
        label.textAlignment = .center
        return label
    }()

    private lazy var userImageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        view.isUserInteractionEnabled = true
        view.layer.cornerRadius = 80
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.accent.cgColor
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        view.addGestureRecognizer(tapGesture)
        return view
    }()

    private lazy var editButton: UIButton = {
        let button = UIButton()
        button.setImage(AssetImage.Icons.penIcon.image.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var bottomStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameLabel, editButton])
        stack.spacing = 8
        stack.alignment = .center
        stack.distribution = .fillProportionally
        return stack
    }()

    // MARK: - Public Properties

    var onEditButtonTapped: VoidHandler?
    var onProfileImageTapped: VoidHandler?

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

    func configure(with user: User) {
        updateNameLabel(with: user.name)
        updateUserImage(with: user.profileImageData)
    }

    func updateNameLabel(with name: String?) {
        nameLabel.text = name
    }

    func updateUserImage(with imageData: Data?) {
        var image: UIImage?
        if let imageData {
            image = UIImage(data: imageData)
        } else {
            image = AssetImage.Images.userIcon.image
        }
        userImageView.image = image
    }

    // MARK: - Private Methods

    private func configureUI() {
        selectionStyle = .none
        contentView.addSubviews(userImageView, bottomStack)
    }

    private func configureLayout() {
        UIView.doNotTAMIC(for: userImageView, bottomStack)
        configureUserImageViewLayout()
        configureBottomStackViewLayout()
        configureEditButtonLayout()
    }

    private func configureUserImageViewLayout() {
        [
            userImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 36),
            userImageView.heightAnchor.constraint(equalToConstant: 160),
            userImageView.widthAnchor.constraint(equalTo: userImageView.heightAnchor),
            userImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ].activate()
    }

    private func configureBottomStackViewLayout() {
        [
            bottomStack.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 26),
            bottomStack.heightAnchor.constraint(equalToConstant: 30),
            bottomStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -29),
            bottomStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ].activate()
    }

    private func configureEditButtonLayout() {
        [
            editButton.heightAnchor.constraint(equalToConstant: 24),
            editButton.widthAnchor.constraint(equalTo: editButton.heightAnchor)
        ].activate()
    }

    @objc private func editButtonTapped() {
        onEditButtonTapped?()
    }

    @objc private func profileImageTapped() {
        onProfileImageTapped?()
    }
}
