//
//  PersonDetailViewController.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 9.11.2020.
//

import UIKit

final class PersonDetailViewController: ViewController {

    private enum Constant {

        static let backdropPadding = UIEdgeInsets(top: Layout.margin,
                                                  left: 0,
                                                  bottom: 0,
                                                  right: 0)
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

    private let detailStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = Layout.margin
        return stackView
    }()

    private let nameTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .natural
        label.textColor = Theme.label
        // TODO: Add localization
        label.text = "Name"
        return label
    }()

    private let nameValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .natural
        label.textColor = Theme.label
        return label
    }()

    private let biographyTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .natural
        label.textColor = Theme.label
        // TODO: Add localization
        label.text = "Biograpy"
        return label
    }()

    private let biographyValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .natural
        label.textColor = Theme.label
        return label
    }()

    private let birthPlaceTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .natural
        label.textColor = Theme.label
        // TODO: Add localization
        label.text = "Birth Place"
        return label
    }()

    private let birthPlaceValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .natural
        label.textColor = Theme.label
        return label
    }()

    private let birthdayTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .natural
        label.textColor = Theme.label
        // TODO: Add localization
        label.text = "Birthday"
        return label
    }()

    private let birthdayValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .natural
        label.textColor = Theme.label
        return label
    }()

    private let departmentTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .natural
        label.textColor = Theme.label
        // TODO: Add localization
        label.text = "Department"
        return label
    }()

    private let departmentValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .natural
        label.textColor = Theme.label
        return label
    }()

    private var viewModel: PersonDetailViewProtocol

    // MARK: Lifecycle

    init(with viewModel: PersonDetailViewProtocol) {

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
        viewModel.fetchPersonDetail()
    }
}

// MARK: State Change Handler

private extension PersonDetailViewController {

    func apply(_ change: PersonDetailViewState.Change) {
        switch change {
        case .loading(let isLoading):
            isLoading ? showLoadingView() : removeLoadingView()
        case .person(let person):
            backdropImageView.imagePath = person.profilePath
            nameValueLabel.text = person.name
            biographyValueLabel.text = person.biography
            birthPlaceValueLabel.text = person.placeOfBirth
            birthdayValueLabel.text = person.birthday
            departmentValueLabel.text = person.knownForDepartment
        }
    }
}

// MARK: Private Helpers

private extension PersonDetailViewController {

    func prepareViews() {

        // TODO: Add localization
        title = "Person Detail"
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
        contentView.dock(view: backdropImageView,
                         constants: Constant.backdropPadding,
                         excludingEdge: .bottom)

        contentView.addSubview(detailStackView)
        constraints.append(contentsOf: [
            contentView.my_trailingAnchor.constraint(equalTo: detailStackView.my_trailingAnchor,
                                                     constant: Layout.margin),
            detailStackView.my_leadingAnchor.constraint(equalTo: contentView.my_leadingAnchor,
                                                        constant: Layout.margin),
            detailStackView.my_topAnchor.constraint(equalTo: backdropImageView.my_bottomAnchor,
                                                    constant: Layout.margin),
            detailStackView.my_bottomAnchor.constraint(equalTo: contentView.my_bottomAnchor,
                                                       constant: -Layout.margin)
        ])

        detailStackView.addArrangedSubview(nameTitleLabel)
        detailStackView.addArrangedSubview(nameValueLabel)
        detailStackView.addArrangedSubview(biographyTitleLabel)
        detailStackView.addArrangedSubview(biographyValueLabel)
        detailStackView.addArrangedSubview(birthPlaceTitleLabel)
        detailStackView.addArrangedSubview(birthPlaceValueLabel)
        detailStackView.addArrangedSubview(birthdayTitleLabel)
        detailStackView.addArrangedSubview(birthdayValueLabel)
        detailStackView.addArrangedSubview(departmentTitleLabel)
        detailStackView.addArrangedSubview(departmentValueLabel)

        constraints.append(contentsOf: [
            detailStackView.my_leadingAnchor.constraint(equalTo: nameTitleLabel.my_leadingAnchor,
                                                        constant: Layout.margin),
            detailStackView.my_trailingAnchor.constraint(equalTo: nameTitleLabel.my_trailingAnchor,
                                                         constant: -Layout.margin),
            detailStackView.my_leadingAnchor.constraint(equalTo: nameValueLabel.my_leadingAnchor,
                                                        constant: Layout.margin),
            detailStackView.my_trailingAnchor.constraint(equalTo: nameValueLabel.my_trailingAnchor,
                                                         constant: -Layout.margin),
            detailStackView.my_leadingAnchor.constraint(equalTo: biographyTitleLabel.my_leadingAnchor,
                                                        constant: Layout.margin),
            detailStackView.my_trailingAnchor.constraint(equalTo: biographyTitleLabel.my_trailingAnchor,
                                                         constant: -Layout.margin),
            detailStackView.my_leadingAnchor.constraint(equalTo: biographyValueLabel.my_leadingAnchor,
                                                        constant: Layout.margin),
            detailStackView.my_trailingAnchor.constraint(equalTo: biographyValueLabel.my_trailingAnchor,
                                                         constant: -Layout.margin),
            detailStackView.my_leadingAnchor.constraint(equalTo: birthPlaceTitleLabel.my_leadingAnchor,
                                                        constant: Layout.margin),
            detailStackView.my_trailingAnchor.constraint(equalTo: birthPlaceTitleLabel.my_trailingAnchor,
                                                         constant: -Layout.margin),
            detailStackView.my_leadingAnchor.constraint(equalTo: birthPlaceValueLabel.my_leadingAnchor,
                                                        constant: Layout.margin),
            detailStackView.my_trailingAnchor.constraint(equalTo: birthPlaceValueLabel.my_trailingAnchor,
                                                         constant: -Layout.margin),
            detailStackView.my_leadingAnchor.constraint(equalTo: birthdayTitleLabel.my_leadingAnchor,
                                                        constant: Layout.margin),
            detailStackView.my_trailingAnchor.constraint(equalTo: birthdayTitleLabel.my_trailingAnchor,
                                                         constant: -Layout.margin),
            detailStackView.my_leadingAnchor.constraint(equalTo: birthdayValueLabel.my_leadingAnchor,
                                                        constant: Layout.margin),
            detailStackView.my_trailingAnchor.constraint(equalTo: birthdayValueLabel.my_trailingAnchor,
                                                         constant: -Layout.margin),
            detailStackView.my_leadingAnchor.constraint(equalTo: departmentTitleLabel.my_leadingAnchor,
                                                        constant: Layout.margin),
            detailStackView.my_trailingAnchor.constraint(equalTo: departmentTitleLabel.my_trailingAnchor,
                                                         constant: -Layout.margin),
            detailStackView.my_leadingAnchor.constraint(equalTo: departmentValueLabel.my_leadingAnchor,
                                                        constant: Layout.margin),
            detailStackView.my_trailingAnchor.constraint(equalTo: departmentValueLabel.my_trailingAnchor,
                                                         constant: -Layout.margin)
        ])

        NSLayoutConstraint.activate(constraints)

    }
}
