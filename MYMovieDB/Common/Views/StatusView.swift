//
//  StatusView.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 7.11.2020.
//

import UIKit

final class StatusView: UIView {

    private enum Constant {

        static let iconImageViewPadding = UIEdgeInsets(top: Layout.margin,
                                                       left: Layout.margin,
                                                       bottom: -Layout.margin,
                                                       right: -Layout.margin)
    }

    // MARK: Properties

    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()

    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()

    private let holderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()

    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        return imageView
    }()

    private let messageLabel: UILabel = {
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
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        prepareViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public Configuration

extension StatusView {

    /// Configures view with given parameters
    /// - Parameters:
    ///   - imageName: Image name
    ///   - message: Message text
    func configure(with imageName: String, message: String) {
        iconImageView.image = UIImage(named: imageName)
        messageLabel.text = message
        layoutIfNeeded()
    }
}

// MARK: Private Configuration

private extension StatusView {

    func prepareViews() {
        addSubview(scrollView)
        dock(view: scrollView)

        scrollView.addSubview(contentView)
        scrollView.dock(view: contentView)
        contentView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        let contentViewHeightConstraint = contentView.heightAnchor.constraint(equalTo: heightAnchor)
        contentViewHeightConstraint.priority = .defaultLow
        contentViewHeightConstraint.isActive = true

        contentView.addSubview(holderView)
        NSLayoutConstraint.activate([
            holderView.my_centerXAnchor.constraint(equalTo: contentView.my_centerXAnchor),
            holderView.my_centerYAnchor.constraint(equalTo: contentView.my_centerYAnchor),
            holderView.my_topAnchor.constraint(greaterThanOrEqualTo: contentView.my_topAnchor),
            holderView.my_bottomAnchor.constraint(lessThanOrEqualTo: contentView.my_bottomAnchor),
            holderView.my_leadingAnchor.constraint(greaterThanOrEqualTo: contentView.my_leadingAnchor),
            holderView.my_trailingAnchor.constraint(lessThanOrEqualTo: contentView.my_trailingAnchor)
        ])

        holderView.addSubview(iconImageView)
        holderView.dock(view: iconImageView,
                        constants: Constant.iconImageViewPadding,
                        excludingEdge: .bottom)

        holderView.addSubview(messageLabel)
        holderView.dock(view: messageLabel,
                        constants: Constant.iconImageViewPadding,
                        excludingEdge: .top)

        iconImageView.my_bottomAnchor.constraint(equalTo: messageLabel.my_topAnchor,
                                                 constant: -Layout.margin).isActive = true
    }
}
