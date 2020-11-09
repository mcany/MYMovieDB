//
//  MovieDetailViewModel.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 8.11.2020.
//

final class MovieDetailViewModel {

    // MARK: Properties

    private let movieID: Int

    private let dataController: MovieDetailDataProtocol

    private let state = MovieDetailViewState()

    // MARK: Lifecycle

    init(with movieID: Int, dataController: MovieDetailDataProtocol ) {
        self.movieID = movieID
        self.dataController = dataController
    }
}

// MARK: MovieDetailViewProtocol

extension MovieDetailViewModel: MovieDetailViewProtocol {

    var stateChangeHandler: MovieDetailViewStateOnChange? {
        get { return state.onChange }
        set { state.onChange = newValue }
    }

    var casts: [Cast] {
        return state.casts ?? []
    }

    var castCount: Int {
        return state.casts?.count ?? 0
    }

    func cast(at index: Int) -> Cast? {
        return state.casts?[safe: index]
    }

    func selectCast(at index: Int) {
        state.selectedCast = cast(at: index)
    }
}

// MARK: Data Functions

extension MovieDetailViewModel {

    func fetchMovieDetail() {

        state.loading = true
        dataController.fetchMovieDetail(movieID: movieID) { [weak self] (response, _) in

            guard let strongSelf = self,
                  let movie = response else {
                return
            }

            strongSelf.dataController.fetchMovieCredits(movieID: strongSelf.movieID) { [weak self] (creditResponse, _) in

                self?.state.loading = false
                self?.state.movie = MovieViewData(movie: movie)
                self?.state.casts = creditResponse?.casts
            }
        }
    }
}
