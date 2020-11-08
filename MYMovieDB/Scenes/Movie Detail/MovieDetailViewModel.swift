//
//  MovieDetailViewModel.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 8.11.2020.
//

final class MovieDetailViewModel: MovieDetailViewProtocol {

    private let movieID: Int

    private let dataController = MovieDetailDataController()

    private let state = MovieDetailViewState()

    var stateChangeHandler: MovieDetailViewStateOnChange? {
        get { return state.onChange }
        set { state.onChange = newValue }
    }

    // MARK: Lifecycle

    init(with movieID: Int) {
        self.movieID = movieID
    }
}

// MARK: Data Functions

extension MovieDetailViewModel {

    func fetchMovieDetail() {
        state.loading = true
        dataController.fetchMovieDetail(movieID: movieID) { [weak self] (response, _) in
            self?.state.loading = false
            guard let movie = response else {
                return
            }
            self?.state.movie = MovieViewData(movie: movie)
        }
    }
}
