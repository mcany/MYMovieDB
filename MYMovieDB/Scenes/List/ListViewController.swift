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

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        tableView.my_register(ListViewTableViewCell.self)
        return tableView
    }()

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

        view.addSubview(tableView)
        view.dock(view: tableView)
        tableView.dataSource = self
    }
}

// MARK: UITableViewDataSource

extension ListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return viewModel.movieCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: ListViewTableViewCell = tableView.my_dequeueReusableCell(for: indexPath)
        let movie = viewModel.movie(at: indexPath.row)
        cell.configure(imagePath: movie?.posterPath)
        cell.configure(title: movie?.title)
        cell.configure(date: movie?.releaseDate)
        return cell
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
            } else {
                tableView.reloadData()
            }
        }
    }
}
