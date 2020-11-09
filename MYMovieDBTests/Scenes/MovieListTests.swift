//
//  MovieListTests.swift
//  MYMovieDBTests
//
//  Created by Mertcan Yigin on 9.11.2020.
//

@testable import MYMovieDB
import XCTest

private typealias ViewModel = ListViewProtocol
private typealias Change = ListViewState.Change

private class Box {

    var viewModel: ViewModel
    var changes: [Change] = []

    init() {
        viewModel = ListViewModel(with: DummyListViewDataController())
        viewModel.stateChangeHandler = { [weak self] change in
            self?.changes.append(change)
        }
    }
}

final class MovieListTests: XCTestCase {

    private var box: Box!

    override func setUp() {
        super.setUp()
        box = Box()
    }

    func testFetcMovies() {
        let movie1 = Movie(identifier: 635302,
                           title: "Test",
                           posterPath: nil,
                           genres: nil,
                           releaseDateString: nil,
                           backdropPath: nil,
                           overview: nil,
                           hasVideo: nil,
                           rating: nil)

        let movie2 = Movie(identifier: 531219,
                           title: "Test2",
                           posterPath: nil,
                           genres: nil,
                           releaseDateString: nil,
                           backdropPath: nil,
                           overview: nil,
                           hasVideo: nil,
                           rating: nil)

        XCTAssertTrue(box.changes.count == 0)

        box.viewModel.fetchMovies()

        XCTAssertTrue(box.changes.count == 3)
        XCTAssertTrue(box.changes[0] == Change.loading(true))
        XCTAssertTrue(box.changes[1] == Change.loading(false))
        XCTAssertTrue(box.changes[2] == Change.movies([movie1, movie2]))
    }

    func testFetcSearch() {

        let result1 = Result(mediaType: nil,
                             name: nil,
                             id: 635302,
                             posterPath: nil,
                             title: "Test",
                             profilePath: nil)

        let result2 = Result(mediaType: nil,
                             name: nil,
                             id: 531219,
                             posterPath: nil,
                             title: "Test2",
                             profilePath: nil)

        XCTAssertTrue(box.changes.count == 0)

        box.viewModel.search(with: nil)
        XCTAssertTrue(box.changes[0] == Change.viewType)
        XCTAssertTrue(box.changes.count == 1)

        box.viewModel.search(with: "A")
        XCTAssertTrue(box.changes.count == 1)

        let expectation = self.expectation(description: "Searching")

        box.viewModel.search(with: "test")

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(box.changes.count == 3)
        XCTAssertTrue(box.changes[1] == Change.viewType)
        XCTAssertTrue(box.changes[2] == Change.results([result1, result2]))
    }
}

// MARK: Equatable Extensions

extension ListViewState.Change: Equatable {

    public static func == (lhs: ListViewState.Change,
                           rhs: ListViewState.Change) -> Bool {
        switch (lhs, rhs) {
        case let ((.loading(lhsState)),
                  (.loading(rhsState))):
            return lhsState == rhsState
        case let ((.movies(lhsState)),
                  (.movies(rhsState))):
            return lhsState?.count == rhsState?.count
        case let ((.selectedMovieID(lhsState)),
                  (.selectedMovieID(rhsState))):
            return lhsState == rhsState
        case let ((.results(lhsState)),
                  (.results(rhsState))):
            return lhsState.count == rhsState.count
        case ((.viewType),
              (.viewType)):
            return true
        default:
            return false
        }
    }
}
