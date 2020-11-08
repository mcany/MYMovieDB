//
//  ListViewModel.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 7.11.2020.
//

final class ListViewModel: ListViewProtocol {

    // MARK: Properties

    private let dataController: ListViewDataProtocol

    private let state = ListViewState()

    var stateChangeHandler: ListViewStateOnChange? {
        get { return state.onChange }
        set { state.onChange = newValue }
    }

    var movieCount: Int {
        return (state.movies ?? []).count
    }

    // MARK: Lifecycle

    init(with dataController: ListViewDataProtocol) {
        self.dataController = dataController
    }
}

// MARK: Public Methods

extension ListViewModel {

    func movie(at index: Int) -> MovieViewData? {
        guard let movie = state.movies?[safe: index] else {
            return nil
        }
        return MovieViewData(movie: movie)
    }

    func selectMovie(at index: Int) {
        state.selectedMovie = state.movies?[safe: index]
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
}
