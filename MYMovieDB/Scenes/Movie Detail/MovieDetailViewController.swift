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

        enum CollectionView {

            static let estimatedHeight: CGFloat = 100
            static let minimumLineSpacing: CGFloat = 2 * Layout.margin
            static let insets = UIEdgeInsets(top: 0,
                                             left: Layout.margin,
                                             bottom: 0,
                                             right: Layout.margin)
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

    private let videoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = Layout.margin
        return stackView
    }()

    private let videoTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .natural
        label.textColor = Theme.label
        // TODO: Add localization
        label.text = "Video"
        return label
    }()

    private var castCollectionViewHeightConstraint: NSLayoutConstraint!

    private let castCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        return collectionView
    }()

    private var viewModel: MovieDetailViewProtocol

    private var router: MovieDetailRouting

    // MARK: Resizing Cell

    private var collectionSize: CGSize = .zero

    private let collectionSizingCell: MovieDetailCollectionViewCell = {
        let sizingCell = MovieDetailCollectionViewCell()
        sizingCell.translatesAutoresizingMaskIntoConstraints = false
        return sizingCell
    }()

    // MARK: Lifecycle

    init(with viewModel: MovieDetailViewProtocol, router: MovieDetailRouting) {

        self.viewModel = viewModel
        self.router = router
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
            posterImageView.imagePath = movie.imagePath
            titleLabel.text = movie.name
            ratingValueLabel.text = movie.rating
            summaryTitleLabel.text = movie.overview
            videoStackView.isHidden = !movie.hasVideo
        case .casts:
            castCollectionView.reloadData()
        case .selectedCast(let castID):
            guard let navigationController = navigationController else {
                return
            }
            router.proceedToPersonDetail(current: navigationController, personID: castID)
        }
    }
}

// MARK: UICollectionViewDataSource

extension MovieDetailViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.castCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MovieDetailCollectionViewCell = collectionView.my_dequeueReusableCell(forIndexPath: indexPath)
        guard let cast = viewModel.cast(at: indexPath.row) else {
            return UICollectionViewCell()
        }
        cell.configure(with: cast)
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension MovieDetailViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        if collectionSize == .zero {
            calculateCollectionCellSize()
        }
        castCollectionViewHeightConstraint.constant = collectionSize.height
        collectionView.frame.size.height = collectionSize.height
        return collectionSize
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {

        return Constant.CollectionView.insets
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return Constant.CollectionView.minimumLineSpacing
    }
}

// MARK: UICollectionViewDelegate

extension MovieDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        viewModel.selectCast(at: indexPath.row)
    }
}

// MARK: Private Helpers

private extension MovieDetailViewController {

    func calculateCollectionCellSize() {
        viewModel.casts.enumerated().forEach { index, _ in
            var size: CGSize = .zero
            var fittingSize = UIView.layoutFittingCompressedSize
            fittingSize.width = castCollectionView.bounds.size.width - (2 * Layout.margin)

            let cell = MovieDetailCollectionViewCell()
            guard let cast = viewModel.cast(at: index) else {
                return
            }
            cell.configure(with: cast)
            cell.layoutIfNeeded()
            size = cell.systemLayoutSizeFitting(fittingSize,
                                                withHorizontalFittingPriority: .required,
                                                verticalFittingPriority: .defaultLow)
            if collectionSize.height > size.height {
                size.height = collectionSize.height
            }
            collectionSize = size
        }
    }

    func prepareViews() {

        // TODO: Add localization
        title = "Movie Detail"

        castCollectionView.dataSource = self
        castCollectionView.delegate = self
        castCollectionView.my_register(MovieDetailCollectionViewCell.self)
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
                                                    constant: Constant.inset)
        ])

        detailStackView.addArrangedSubview(ratingTitleLabel)
        detailStackView.addArrangedSubview(ratingValueLabel)
        detailStackView.addArrangedSubview(summaryTitleLabel)
        detailStackView.addArrangedSubview(summaryValueLabel)
        detailStackView.addArrangedSubview(castTitleLabel)
        detailStackView.addArrangedSubview(videoStackView)

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
                                                         constant: -Layout.margin),
            detailStackView.my_leadingAnchor.constraint(equalTo: videoStackView.my_leadingAnchor,
                                                        constant: Layout.margin),
            detailStackView.my_trailingAnchor.constraint(equalTo: videoStackView.my_trailingAnchor,
                                                         constant: -Layout.margin)
        ])

        videoStackView.addArrangedSubview(videoTitleLabel)
        constraints.append(contentsOf: [
            videoStackView.my_leadingAnchor.constraint(equalTo: videoTitleLabel.my_leadingAnchor,
                                                       constant: Layout.margin),
            videoStackView.my_trailingAnchor.constraint(equalTo: videoTitleLabel.my_trailingAnchor,
                                                        constant: -Layout.margin)
        ])

        contentView.addSubview(castCollectionView)
        castCollectionViewHeightConstraint = castCollectionView.heightAnchor.constraint(
            equalToConstant: Constant.CollectionView.estimatedHeight)
        constraints.append(contentsOf: [
            castCollectionViewHeightConstraint,
            contentView.my_trailingAnchor.constraint(equalTo: castCollectionView.my_trailingAnchor,
                                                     constant: Layout.margin),
            castCollectionView.my_leadingAnchor.constraint(equalTo: contentView.my_leadingAnchor,
                                                           constant: Layout.margin),
            castCollectionView.my_bottomAnchor.constraint(equalTo: contentView.my_bottomAnchor,
                                                          constant: -Layout.margin),
            castCollectionView.my_topAnchor.constraint(equalTo: detailStackView.my_bottomAnchor,
                                                       constant: Layout.margin)
        ])

        NSLayoutConstraint.activate(constraints)
    }
}
