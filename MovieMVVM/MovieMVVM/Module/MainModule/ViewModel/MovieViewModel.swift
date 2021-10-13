// MovieViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// MovieViewModelProtocol
protocol MovieViewModelProtocol: AnyObject {
    var films: [ParametrFilms]? { get set }
    var reloadData: (() -> ())? { get set }
    func getTopRated()
}

/// MovieViewModel
final class MovieViewModel: MovieViewModelProtocol {
    // MARK: - Public Properties

    var films: [ParametrFilms]?
    var reloadData: (() -> ())?

    // MARK: - Private Properties

    private var movieAPIService: MovieAPIServiceProtocol

    // MARK: - Initializers

    init(movieAPIService: MovieAPIServiceProtocol) {
        self.movieAPIService = movieAPIService
        getTopRated()
    }

    // MARK: - Public Methods

    func getTopRated() {
        movieAPIService.getRated { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(result):
                self.films = result
                DispatchQueue.main.async {
                    self.reloadData?()
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
