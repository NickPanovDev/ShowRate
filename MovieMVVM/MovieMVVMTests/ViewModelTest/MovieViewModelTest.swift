// MovieViewModelTest.swift
// Copyright © RoadMap. All rights reserved.

@testable import MovieMVVM
import XCTest

/// MockAPIService
final class MockAPIService: MovieAPIServiceProtocol {
    private var parametrFilms: [ParametrFilms]?

    init() {}
    convenience init(movie: [ParametrFilms]) {
        self.init()
        parametrFilms = movie
    }

    func getRated(complition: @escaping (Result<[ParametrFilms], Error>) -> Void) {
        guard let movies = parametrFilms else { return }
        complition(.success(movies))
    }

    func getDetailRated(id: Int?, complition: @escaping (Result<DetailModel, Error>) -> Void) {}
}

/// MovieViewModelTest
final class MovieViewModelTest: XCTestCase {
    private var movieViewModel: MovieViewModel!
    private var realmProvider: RealmProviderProtocol!
    private var repository: RepositoryProtocol!
    private var movieAPIServise: MovieAPIServiceProtocol!

    override func setUpWithError() throws {
        movieAPIServise = MockAPIService()
        realmProvider = RealmProvider()
        repository = RealmRepository(realmProvider: realmProvider)
    }

    override func tearDownWithError() throws {}

    func testGetRated() {
        movieViewModel = MovieViewModel(
            movieAPIService: movieAPIServise,
            repositoryProtocol: repository
        )
        var resultsMovie: [ParametrFilms]?
        movieAPIServise.getRated { result in
            switch result {
            case let .success(result):
                resultsMovie = result
            default:
                break
            }
        }
        XCTAssertNotEqual(resultsMovie?.count, 0)
    }
}
