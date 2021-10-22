// DetailViewModelTest.swift
// Copyright © RoadMap. All rights reserved.

@testable import MovieMVVM
import XCTest

/// MockMovieAPIService
final class MockMovieAPIService: MovieAPIServiceProtocol {
    private var detailModel: DetailModel?
    init() {}
    convenience init(movie: DetailModel) {
        self.init()
        detailModel = movie
    }

    private func detail() -> DetailModel? {
        detailModel = DetailModel()
        detailModel?.posterPath = "BAZ"
        detailModel?.title = "Bar"
        detailModel?.overview = "Foo"
        return detailModel
    }

    func getRated(complition: @escaping (Result<[ParametrFilms], Error>) -> Void) {}

    func getDetailRated(id: Int?, complition: @escaping (Result<DetailModel, Error>) -> Void) {
        guard let movies = detail() else { return }
        complition(.success(movies))
    }
}

/// DetailViewModelTest
final class DetailViewModelTest: XCTestCase {
    private var detailViewModel: DetailViewModel!
    private var realmProvider: RealmProviderProtocol!
    private var repository: RepositoryProtocol!
    private var movieAPIService: MovieAPIServiceProtocol!

    override func setUpWithError() throws {
        movieAPIService = MockMovieAPIService()
        realmProvider = RealmProvider()
        repository = RealmRepository(realmProvider: realmProvider)
    }

    override func tearDownWithError() throws {}

    func testGetDetailRated() {
        detailViewModel = DetailViewModel(movieAPIService: movieAPIService, id: 0, repositoryProtocol: repository)
        var resultsMovie: DetailModel!
        movieAPIService.getDetailRated(id: 1) { result in
            switch result {
            case let .success(details):
                resultsMovie = details
            default:
                break
            }
            XCTAssertNotNil(resultsMovie)
        }
    }
}
