// DetailViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// DetailViewModelProtocol
protocol DetailViewModelProtocol: AnyObject {
    var id: Int? { get set }
    var films: Results<DetailModel>? { get set }
//    var films: DetailModel? { get set }
    var reloadData: (() -> ())? { get set }
    func getDetailMovie()
}

/// DetailViewModel
final class DetailViewModel: DetailViewModelProtocol {
    // MARK: - Public Properties

    var id: Int?
    var films: Results<DetailModel>?
//    var films: DetailModel?
    var reloadData: VoidHandler?

    // MARK: - Private Properties

    private var movieAPIService: MovieAPIServiceProtocol
    private var repository: RepositoryProtocol?

    // MARK: - Initializers

    init(movieAPIService: MovieAPIServiceProtocol, id: Int?, repositoryProtocol: RepositoryProtocol) {
        self.movieAPIService = movieAPIService
        self.id = id
        repository = repositoryProtocol
        getDetailMovie()
    }

    // MARK: - Public Method

    func getDetailMovie() {
        movieAPIService.getDetailRated(id: id) { [weak self] parametrFilms in
            guard let self = self else { return }
            switch parametrFilms {
            case let .success(parametrFilms):
                let movies = parametrFilms
                self.repository?.saveSingle(object: movies)
//                self.films = parametrFilms
                DispatchQueue.main.async {
                    self.reloadData?()
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }

    func getMovieDetailRealm() {
        guard let getMovieDetailFromRealm = repository?.get(type: DetailModel.self) else { return }
        films = getMovieDetailFromRealm
    }
}
