//
//  ListViewController.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 7.11.2020.
//

import UIKit

final class ListViewController: ViewController {

    // MARK: Properties

    private var viewModel: ListViewProtocol

    // MARK: Lifecycle

    init(with viewModel: ListViewProtocol) {

        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        prepareViews()

        viewModel.stateChangeHandler = { [unowned self] change in
            self.apply(change)
        }
        viewModel.fetchMovies()
    }
}

// MARK: Helpers

extension ListViewController {

    private func prepareViews() {

        // TODO: Add localization
        title = "My list"
    }
}

// MARK: State Change Handler

private extension ListViewController {

    func apply(_ change: ListViewState.Change) {
        switch change {
        case .loading(let isLoading):
            isLoading ? showLoadingView() : removeLoadingView()
        case .movies(let movies):
            if movies.isNilOrEmpty {
                // TODO: Add localization
                showStatusView(iconName: "info",
                               message: "Movie list is empty or cannot be loaded!")
            }
        }
    }
}
