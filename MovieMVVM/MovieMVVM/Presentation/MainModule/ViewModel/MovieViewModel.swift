// MovieViewModel.swift
// Copyright © ShowRate. All rights reserved.

import Foundation
import RealmSwift

protocol MovieViewModelProtocol: AnyObject {
    var films: Results<ParametrFilms>? { get set }
    var reloadData: VoidHandler? { get set }
    func getTopRated()
}

final class MovieViewModel: MovieViewModelProtocol {
    // MARK: - Public Properties

    var films: Results<ParametrFilms>?
    var reloadData: VoidHandler?

    // MARK: - Private Properties

    private var movieAPIService: MovieAPIServiceProtocol
    private var repository: RepositoryProtocol?

    // MARK: - Initializers

    init(movieAPIService: MovieAPIServiceProtocol, repositoryProtocol: RepositoryProtocol) {
        repository = repositoryProtocol
        self.movieAPIService = movieAPIService
        getTopRated()
        getMovieRealm()
    }

    // MARK: - Public Methods

    func getTopRated() {
        movieAPIService.getRated { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(result):
                let movies = result
                self.repository?.save(object: movies)
                DispatchQueue.main.async {
                    self.reloadData?()
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }

    func getMovieRealm() {
        guard let getMovieFromRealm = repository?.get(type: ParametrFilms.self) else { return }
        films = getMovieFromRealm
    }
}
