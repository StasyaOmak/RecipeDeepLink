// ProfileCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка содержищая информацию о пользователе
final class ProfileCell: UITableViewCell {
    // MARK: - Visual Components

    private let userImageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        return view
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .verdanaBold?.withSize(25)
        label.textColor = .textAccent
        label.textAlignment = .center
        return label
    }()

    private lazy var editButton: UIButton = {
        let button = UIButton()
        button.setImage(.penIcon.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(didTapEditButton), for: .touchUpInside)
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
        selectionStyle = .none
        userImageView.image = UIImage(user.profileImageName)
        nameLabel.text = user.name
    }

    func updateNameLabel(with name: String?) {
        nameLabel.text = name
    }

    // MARK: - Private Methods

    private func configureUI() {
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

    @objc private func didTapEditButton() {
        onEditButtonTapped?()
    }
}
