//
//  ListViewModel.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 7.11.2020.
//

final class ListViewModel: ListViewProtocol {

    private let dataController: ListViewDataProtocol

    init(with dataController: ListViewDataProtocol) {
        self.dataController = dataController
    }

    func fetchMovies() {
        dataController.fetchMovies(page: 1) { (response, error) in
            // TODO: Return fetched movies to VC
            print(response?.movies?.count)
            print(error)
        }
    }
}
