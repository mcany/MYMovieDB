//
//  MovieDetailCollectionViewCell.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 9.11.2020.
//

import UIKit

final class MovieDetailCollectionViewCell: UICollectionViewCell {

    private enum Constant {

        static let margin: CGFloat = 5.0

        enum Tumbnail {
            static let size = CGSize(width: 100, height: 150)
            static let cornerRadius: CGFloat = 6
        }
    }

    // MARK: Properties

    private let detailStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = Layout.margin
        return stackView
    }()

    private let castLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = Theme.label
        return label
    }()

    private let castImageView: ImageView = {
        let imageView = ImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.widthAnchor.constraint(equalToConstant: Constant.Tumbnail.size.width)
            .isActive = true
        imageView.heightAnchor.constraint(equalToConstant: Constant.Tumbnail.size.height)
            .isActive = true
        imageView.layer.cornerRadius = Constant.Tumbnail.cornerRadius
        imageView.layer.masksToBounds = true
        imageView.imageWidth = Constant.Tumbnail.size.width
        return imageView
    }()

    private let characterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = Theme.label
        return label
    }()

    // MARK: Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        prepareViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public Configuration

extension MovieDetailCollectionViewCell {

    func configure(with cast: Cast) {
        castLabel.text = cast.name
        castImageView.imagePath = cast.profilePath
        characterLabel.text = cast.character
    }
}

// MARK: Private Configuration

private extension MovieDetailCollectionViewCell {

    func prepareViews() {

        var constraints: [NSLayoutConstraint] = []

        contentView.addSubview(detailStackView)
        contentView.dock(view: detailStackView)

        detailStackView.addArrangedSubview(castLabel)
        detailStackView.addArrangedSubview(castImageView)
        detailStackView.addArrangedSubview(characterLabel)

        constraints.append(contentsOf: [
            detailStackView.my_leadingAnchor.constraint(equalTo: castLabel.my_leadingAnchor,
                                                        constant: Layout.margin),
            detailStackView.my_trailingAnchor.constraint(equalTo: castLabel.my_trailingAnchor,
                                                         constant: -Layout.margin),
            detailStackView.my_leadingAnchor.constraint(equalTo: castImageView.my_leadingAnchor,
                                                        constant: Layout.margin),
            detailStackView.my_trailingAnchor.constraint(equalTo: castImageView.my_trailingAnchor,
                                                         constant: -Layout.margin),
            detailStackView.my_leadingAnchor.constraint(equalTo: characterLabel.my_leadingAnchor,
                                                        constant: Layout.margin),
            detailStackView.my_trailingAnchor.constraint(equalTo: characterLabel.my_trailingAnchor,
                                                         constant: -Layout.margin)
        ])
    }
}

// MARK: Reusable

extension MovieDetailCollectionViewCell: Reusable { }
