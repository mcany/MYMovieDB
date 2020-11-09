//
//  DummyListViewDataController.swift
//  MYMovieDBTests
//
//  Created by Mertcan Yigin on 9.11.2020.
//

@testable import MYMovieDB
import XCTest

class DummyListViewDataController: ListViewDataProtocol {

    func fetchMovies(page: Int, completion: @escaping FetchMoviesCompletion) {
        let decoder = JSONDecoder()
        let reponse = try? decoder.decode(MoviePopularListResponse.self,
                                          from: movieResponse.data(using: .utf8)!)
        completion(reponse, nil)
        return
    }

    func search(_ query: String, completion: @escaping SearchMultiCompletion) {
        let decoder = JSONDecoder()
        let reponse = try? decoder.decode(SearchMultiResponse.self,
                                          from: movieResponse.data(using: .utf8)!)
        completion(reponse, nil)
        return
    }

    let movieResponse =
        """
    {
    "page": 1,
    "total_results": 10000,
    "total_pages": 500,
    "results": [{
            "popularity": 3778.011,
            "vote_count": 60,
            "video": false,
            "poster_path": "/h8Rb9gBr48ODIwYUttZNYeMWeUU.jpg",
            "id": 635302,
            "adult": false,
            "backdrop_path": "/xoqr4dMbRJnzuhsWDF3XNHQwJ9x.jpg",
            "original_language": "ja",
            "original_title": "劇場版「鬼滅の刃」無限列車編",
            "genre_ids": [
                16,
                28,
                36,
                12,
                14,
                18
            ],
            "title": "Test",
            "vote_average": 6.3,
            "overview": "Tanjirō Kamado, joined with Inosuke Hashibira, a boy raised by boars who wears a boar's head, and Zenitsu Agatsuma, a scared boy who reveals his true power when he sleeps, boards the Infinity Train on a new mission with the Fire Hashira, Kyōjurō Rengoku, to defeat a demon who has been tormenting the people and killing the demon slayers who oppose it!",
            "release_date": "2020-10-16"
        },
        {
            "popularity": 2403.297,
            "vote_count": 569,
            "video": false,
            "poster_path": "/betExZlgK0l7CZ9CsCBVcwO1OjL.jpg",
            "id": 531219,
            "adult": false,
            "backdrop_path": "/8rIoyM6zYXJNjzGseT3MRusMPWl.jpg",
            "original_language": "en",
            "original_title": "Roald Dahl's The Witches",
            "genre_ids": [
                14,
                10751,
                12,
                35,
                27
            ],
            "title": "Test2",
            "vote_average": 7.1,
            "overview": "In late 1967, a young orphaned boy goes to live with his loving grandma in the rural Alabama town of Demopolis. As the boy and his grandmother encounter some deceptively glamorous but thoroughly diabolical witches, she wisely whisks him away to a seaside resort. Regrettably, they arrive at precisely the same time that the world's Grand High Witch has gathered.",
            "release_date": "2020-10-26"
        }
    ]
    }
    """
}
