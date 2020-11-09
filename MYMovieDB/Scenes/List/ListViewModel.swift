//
//  ListViewModel.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 7.11.2020.
//

import Foundation

final class ListViewModel: ListViewProtocol {

    // MARK: Properties

    private let dataController: ListViewDataProtocol

    private let state = ListViewState()

    private var movieResults: [Result]?
    private var tvResults: [Result]?
    private var personResults: [Result]?

    var stateChangeHandler: ListViewStateOnChange? {
        get { return state.onChange }
        set { state.onChange = newValue }
    }

    var searchTask: DispatchWorkItem?

    // MARK: Lifecycle

    init(with dataController: ListViewDataProtocol) {
        self.dataController = dataController
    }
}

// MARK: Public Methods

extension ListViewModel {

    var segmentCount: Int {
        if state.viewType == .list {
            return 1
        } else {
            return MediaType.allCases.count
        }
    }

    func listCount(at section: Int) -> Int {
        if state.viewType == .list {
            return (state.movies ?? []).count
        } else {
            switch section {
            case 0:
                return movieResults?.count ?? 0
            case 1:
                return tvResults?.count ?? 0
            case 2:
                return personResults?.count ?? 0
            default:
                return 0
            }
        }
    }

    func listItem(at indexPath: IndexPath) -> ListViewData? {
        if state.viewType == .list {
            guard let movie = state.movies?[safe: indexPath.row] else {
                return nil
            }
            return MovieViewData(movie: movie)
        } else {
            var results: [Result]?
            switch indexPath.section {
            case 0:
                results = movieResults
            case 1:
                results = tvResults
            case 2:
                results = personResults
            default:
                break
            }
            guard let result = results?[safe: indexPath.row] else {
                return nil
            }
            return ResultViewData(result: result)
        }
    }

    func segmentTitle(at index: Int) -> String? {
        if state.viewType == .list {
            return nil
        } else {
            return MediaType.allCases[index].rawValue
        }
    }

    func selectMovie(at index: Int) {
        state.selectedMovie = state.movies?[safe: index]
    }

    func search(with keyword: String?) {
        searchTask?.cancel()
        guard let keyword = keyword.isNilOrEmpty else {
            state.viewType = .list
            return
        }
        guard keyword.count > 1 else {
            return
        }
        state.viewType = .search
        let task = DispatchWorkItem { [weak self] in
            guard let strongSelf = self else {
                return
            }
            strongSelf.fetchSearch(with: keyword)
        }
        searchTask = task
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1, execute: task)
    }
}

// MARK: Private Methods

private extension ListViewModel {

    func update(_ results: [Result]?) {
        guard let results = results else {
            movieResults = nil
            tvResults = nil
            personResults = nil
            return
        }
        movieResults = results.filter { result in
            result.mediaType == .movie
        }
        tvResults = results.filter { result in
            result.mediaType == .tv
        }
        personResults = results.filter { result in
            result.mediaType == .person
        }
    }
}

// MARK: Data Functions

extension ListViewModel {

    func fetchMovies() {
        state.loading = true
        dataController.fetchMovies(page: 1) { [weak self] (reponse, _) in
            self?.state.loading = false
            self?.state.movies = reponse?.movies
        }
    }

    private func fetchSearch(with keyword: String) {
        dataController.search(keyword) { [weak self] (reponse, _) in
            self?.state.results = reponse?.results
            self?.update(reponse?.results)
        }
    }
}
