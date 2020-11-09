//
//  MovieDetailDataController.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 8.11.2020.
//

final class MovieDetailDataController: MovieDetailDataProtocol {

    func fetchMovieDetail(movieID: Int, completion: @escaping FetchMovieDetailCompletion) {

        let request = MovieDetailRequest(movieID: movieID)
        NetworkManager.shared.send(request: request) { result in
            let response = Movie.model(withJSONData: result.data)
            completion(response, result.error)
        }
    }

    func fetchMovieCredits(movieID: Int, completion: @escaping FetchMovieCreditCompletion) {

        let request = MovieCreditsRequest(movieID: movieID)
        NetworkManager.shared.send(request: request) { result in
            let response = MovieCreditsResponse.model(withJSONData: result.data)
            completion(response, result.error)
        }
    }
}
