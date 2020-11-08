//
//  MovieDetailViewController.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 8.11.2020.
//

import UIKit

final class MovieDetailViewController: ViewController {

    private enum Constant {

        static let inset: CGFloat = 5
        static let padding = UIEdgeInsets(top: Layout.margin,
                                          left: Layout.margin,
                                          bottom: -Layout.margin,
                                          right: -Layout.margin)

        enum Poster {
            static let size = CGSize(width: 100, height: 150)
            static let cornerRadius: CGFloat = 6
            static let padding = UIEdgeInsets(top: inset,
                                              left: inset,
                                              bottom: -inset,
                                              right: -inset)
        }
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

    private let backdropImageView: ImageView = {
        let imageView = ImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.imageWidth = UIScreen.main.bounds.size.width
        imageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width)
            .isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor,
                                          multiplier: 0.66)
            .isActive = true
        return imageView
    }()

    private let posterHolderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()

    private let posterImageView: ImageView = {
        let imageView = ImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.widthAnchor.constraint(equalToConstant: Constant.Poster.size.width)
            .isActive = true
        imageView.heightAnchor.constraint(equalToConstant: Constant.Poster.size.height)
            .isActive = true
        imageView.layer.cornerRadius = Constant.Poster.cornerRadius
        imageView.layer.masksToBounds = true
        imageView.imageWidth = Constant.Poster.size.width
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .natural
        label.textColor = Theme.label
        return label
    }()

    private let detailStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = Layout.margin
        return stackView
    }()

    private let summaryTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .natural
        label.textColor = Theme.label
        // TODO: Add localization
        label.text = "Summary"
        return label
    }()

    private let summaryValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .natural
        label.textColor = Theme.label
        return label
    }()

    private let ratingTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .natural
        label.textColor = Theme.label
        // TODO: Add localization
        label.text = "Rating"
        return label
    }()

    private let ratingValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .natural
        label.textColor = Theme.label
        return label
    }()

    private let castTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .natural
        label.textColor = Theme.label
        // TODO: Add localization
        label.text = "Cast"
        return label
    }()

    private var viewModel: MovieDetailViewProtocol

    // MARK: Lifecycle

    init(with viewModel: MovieDetailViewProtocol) {

        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViews()
        prepareViews()

        viewModel.stateChangeHandler = { [unowned self] change in
            self.apply(change)
        }
        viewModel.fetchMovieDetail()
    }
}

// MARK: State Change Handler

private extension MovieDetailViewController {

    func apply(_ change: MovieDetailViewState.Change) {
        switch change {
        case .loading(let isLoading):
            isLoading ? showLoadingView() : removeLoadingView()
        case .movie(let movie):
            backdropImageView.imagePath = movie.backdropPath
            posterImageView.imagePath = movie.posterPath
            titleLabel.text = movie.title
            summaryTitleLabel.text = movie.overview
        }
    }
}

// MARK: Private Helpers

private extension MovieDetailViewController {

    func prepareViews() {

        // TODO: Add localization
        title = "Movie Detail"
    }

    func configureViews() {

        var constraints: [NSLayoutConstraint] = []

        view.addSubview(scrollView)
        view.dock(view: scrollView)

        scrollView.addSubview(contentView)
        scrollView.dock(view: contentView)
        contentView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        let contentViewHeightConstraint = contentView.heightAnchor.constraint(equalTo: view.heightAnchor)
        contentViewHeightConstraint.priority = .defaultLow
        constraints.append(contentViewHeightConstraint)

        contentView.addSubview(backdropImageView)
        contentView.dock(view: backdropImageView, excludingEdge: .bottom)

        contentView.addSubview(posterHolderView)
        constraints.append(contentsOf: [
                            contentView.my_leadingAnchor.constraint(equalTo: posterHolderView.my_leadingAnchor,
                                                                    constant: -Layout.margin),
                            posterHolderView.centerYAnchor.constraint(equalTo: backdropImageView.my_bottomAnchor)])

        posterHolderView.addSubview(posterImageView)
        posterHolderView.dock(view: posterImageView,
                              constants: Constant.Poster.padding)

        contentView.addSubview(titleLabel)
        constraints.append(contentsOf: [
            contentView.my_trailingAnchor.constraint(equalTo: titleLabel.my_trailingAnchor,
                                                     constant: Constant.inset),
            titleLabel.my_leadingAnchor.constraint(equalTo: posterHolderView.my_trailingAnchor,
                                                   constant: Constant.inset),
            titleLabel.my_topAnchor.constraint(equalTo: backdropImageView.my_bottomAnchor,
                                               constant: Constant.inset),
            titleLabel.my_bottomAnchor.constraint(lessThanOrEqualTo: posterHolderView.my_bottomAnchor)
        ])

        contentView.addSubview(detailStackView)
        constraints.append(contentsOf: [
            contentView.my_trailingAnchor.constraint(equalTo: detailStackView.my_trailingAnchor,
                                                     constant: Layout.margin),
            detailStackView.my_leadingAnchor.constraint(equalTo: contentView.my_leadingAnchor,
                                                        constant: Layout.margin),
            detailStackView.my_topAnchor.constraint(equalTo: posterHolderView.my_bottomAnchor,
                                                    constant: Constant.inset),
            detailStackView.my_bottomAnchor.constraint(equalTo: contentView.my_bottomAnchor,
                                                       constant: -Layout.margin)
        ])

        detailStackView.addArrangedSubview(ratingTitleLabel)
        detailStackView.addArrangedSubview(ratingValueLabel)
        detailStackView.addArrangedSubview(summaryTitleLabel)
        detailStackView.addArrangedSubview(summaryValueLabel)
        detailStackView.addArrangedSubview(castTitleLabel)

        constraints.append(contentsOf: [
            detailStackView.my_leadingAnchor.constraint(equalTo: ratingTitleLabel.my_leadingAnchor,
                                                        constant: Layout.margin),
            detailStackView.my_trailingAnchor.constraint(equalTo: ratingTitleLabel.my_trailingAnchor,
                                                         constant: -Layout.margin),
            detailStackView.my_leadingAnchor.constraint(equalTo: ratingValueLabel.my_leadingAnchor,
                                                        constant: Layout.margin),
            detailStackView.my_trailingAnchor.constraint(equalTo: ratingValueLabel.my_trailingAnchor,
                                                         constant: -Layout.margin),
            detailStackView.my_leadingAnchor.constraint(equalTo: summaryTitleLabel.my_leadingAnchor,
                                                        constant: Layout.margin),
            detailStackView.my_trailingAnchor.constraint(equalTo: summaryTitleLabel.my_trailingAnchor,
                                                         constant: -Layout.margin),
            detailStackView.my_leadingAnchor.constraint(equalTo: summaryValueLabel.my_leadingAnchor,
                                                        constant: Layout.margin),
            detailStackView.my_trailingAnchor.constraint(equalTo: summaryValueLabel.my_trailingAnchor,
                                                         constant: -Layout.margin),
            detailStackView.my_leadingAnchor.constraint(equalTo: castTitleLabel.my_leadingAnchor,
                                                        constant: Layout.margin),
            detailStackView.my_trailingAnchor.constraint(equalTo: castTitleLabel.my_trailingAnchor,
                                                         constant: -Layout.margin)
        ])

        NSLayoutConstraint.activate(constraints)
    }
}
