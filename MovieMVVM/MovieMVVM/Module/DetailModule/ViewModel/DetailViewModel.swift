// DetailViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// DetailViewModelProtocol
protocol DetailViewModelProtocol: AnyObject {
    var id: Int? { get set }
    var films: DetailModel? { get set }
    var reloadData: (() -> ())? { get set }
    func getDetailMovie()
}

/// DetailViewModel
final class DetailViewModel: DetailViewModelProtocol {
    // MARK: - Public Properties

    var id: Int?
    var films: DetailModel?
    var reloadData: VoidHandler?

    // MARK: - Private Properties

    private var movieAPIService: MovieAPIServiceProtocol

    // MARK: - Initializers

    init(movieAPIService: MovieAPIServiceProtocol, id: Int?) {
        self.movieAPIService = movieAPIService
        self.id = id
        getDetailMovie()
    }

    // MARK: - Public Method

    func getDetailMovie() {
        movieAPIService.getDetailRated(id: id) { [weak self] parametrFilms in
            guard let self = self else { return }
            switch parametrFilms {
            case let .success(parametrFilms):
                self.films = parametrFilms
                DispatchQueue.main.async {
                    self.reloadData?()
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
