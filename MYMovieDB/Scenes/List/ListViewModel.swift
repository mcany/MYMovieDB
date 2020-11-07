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

    // MARK: Lifecycle

    init(with dataController: ListViewDataProtocol) {
        self.dataController = dataController
    }
}

// MARK: Data Functions

extension ListViewModel {

    func fetchMovies() {
        state.loading = true
        dataController.fetchMovies(page: 1) { [weak self] (response, error) in
            self?.state.loading = false
            // TODO: Return fetched movies to VC
            self?.state.movies = nil
        }
    }
}
