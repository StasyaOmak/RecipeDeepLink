// CategoryCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///  Ячейк содержащяя категорию
final class CategoryCell: UICollectionViewCell {
    // MARK: - Types

    /// Размерные классы для определения параметров стиля ячейки
    enum SizeClass {
        /// Маленький размер.
        case small
        /// Средний размер.
        case medium
        /// Большой размер.
        case large

        /// Параметры, связанные с каждым размером.
        var parameters: (cornerRadiusRatio: CGFloat, fontSize: CGFloat, captionLabelHeightRatio: CGFloat) {
            switch self {
            case .small:
                (0.11, 16, 0.25)
            case .medium:
                (0.1, 20, 0.17)
            case .large:
                (0.09, 20, 0.2)
            }
        }
    }

    // MARK: - Visual Components

    private let mainImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()

    private let captionLabel = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = .gray.withAlphaComponent(0.82)
        label.textAlignment = .center
        return label
    }()

    private var captionLabelHeightConstraint: NSLayoutConstraint?

    // MARK: - Public Properties

    override var isSelected: Bool {
        didSet {
            switch isSelected {
            case true:
                contentView.layer.borderWidth = 2
                captionLabel.backgroundColor = .accent.withAlphaComponent(0.82)
            case false:
                contentView.layer.borderWidth = 0
                captionLabel.backgroundColor = .gray.withAlphaComponent(0.82)
            }
        }
    }

    // MARK: - Private Properties

    private var sizeClass: SizeClass = .small

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
        configureLayout()
    }

    // MARK: - Life Cycle

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        contentView.layer.cornerRadius = rect.height * sizeClass.parameters.cornerRadiusRatio
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let captionLabelHeight = bounds.height * sizeClass.parameters.captionLabelHeightRatio
        captionLabelHeightConstraint?.deactivate()
        captionLabelHeightConstraint = captionLabel.heightAnchor.constraint(equalToConstant: captionLabelHeight)
        captionLabelHeightConstraint?.activate()
    }

    // MARK: - Public Methods

    func configure(with category: Category, sizeClass: SizeClass) {
        self.sizeClass = sizeClass
        mainImageView.image = UIImage(category.imageName)
        captionLabel.text = category.dishCategory.rawValue
        captionLabel.font = .verdana(size: sizeClass.parameters.fontSize)
    }

    // MARK: - Private Methods

    private func configureUI() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.6
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 0, height: 4)

        contentView.layer.masksToBounds = true
        contentView.layer.frame = contentView.layer.frame.insetBy(dx: 1, dy: 1)
        contentView.layer.borderColor = UIColor.accent.cgColor
        contentView.layer.cornerCurve = .continuous
        contentView.addSubviews(mainImageView, captionLabel)
    }

    private func configureLayout() {
        UIView.doNotTAMIC(for: mainImageView, captionLabel)
        configureMaintImageViewLayout()
        configureCaptionLabelLayout()
    }

    private func configureMaintImageViewLayout() {
        [
            mainImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ].activate()
    }

    private func configureCaptionLabelLayout() {
        [
            captionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            captionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            captionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ].activate()
    }
}
