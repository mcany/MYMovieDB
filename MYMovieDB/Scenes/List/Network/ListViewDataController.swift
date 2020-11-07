//
//  ListViewDataController.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 7.11.2020.
//

final class ListViewDataController: ListViewDataProtocol {

    /// Fetches movie list with given parameters
    /// - Parameters:
    ///   - page: Page number to fetch
    ///   - completion: Completion block
    func fetchMovies(page: Int, completion: @escaping FetchMoviesCompletion) {

        let request = MoviePopularListRequest(page: page)
        NetworkManager.shared.send(request: request) { result in
            let response = MoviePopularListResponse.model(withJSONData: result.data)
            completion(response, result.error)
        }
    }
}
