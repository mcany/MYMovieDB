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

    private let router: ListViewRouting

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

    private lazy var tableHeaderView: UIView = {
        let view = UIView(frame: .zero)
        view.addSubview(searchBar)
        view.dock(view: searchBar)
        return view
    }()

    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.applyStyling()
        return searchBar
    }()

    // MARK: Lifecycle

    init(with viewModel: ListViewProtocol, router: ListViewRouting) {

        self.viewModel = viewModel
        self.router = router
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

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateTableHeaderView()
    }
}

// MARK: Private Helpers

private extension ListViewController {

    func updateTableHeaderView() {
        let headerView = tableView.tableHeaderView
        headerView?.my_sizeToFit()
        tableView.tableHeaderView = headerView
    }

    func prepareViews() {

        // TODO: Add localization
        title = "My list"

        view.addSubview(tableView)
        view.dock(view: tableView)
        tableView.tableHeaderView = tableHeaderView
        tableView.dataSource = self
        tableView.delegate = self

        searchBar.placeholder = "Search"
        searchBar.showsCancelButton = true
        searchBar.delegate = self
        //        navigationItem.titleView = searchBar
    }
}

// MARK: UISearchBarDelegate

extension ListViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(with: searchText)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.endEditing(true)
        viewModel.search(with: nil)
    }
}

// MARK: UITableViewDataSource

extension ListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return viewModel.listCount(at: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: ListViewTableViewCell = tableView.my_dequeueReusableCell(for: indexPath)
        let movie = viewModel.listItem(at: indexPath)
        cell.configure(imagePath: movie?.imagePath)
        cell.configure(title: movie?.name)
        cell.configure(date: movie?.releaseDate)
        return cell
    }
}

// MARK: UITableViewDelegate

extension ListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.segmentTitle(at: section)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.segmentCount
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectMovie(at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: false)
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
                tableView.layoutIfNeeded()
                tableView.contentOffset = .zero
            }
        case .selectedMovieID(let movieID):
            guard let navigationController = navigationController else {
                return
            }
            router.proceedToMovieDetail(current: navigationController, movieID: movieID)
        case .results:
            tableView.reloadData()
        }
    }
}
