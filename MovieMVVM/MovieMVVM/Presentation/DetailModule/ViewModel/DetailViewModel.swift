// DetailViewModel.swift
// Copyright © ShowRate. All rights reserved.

import Foundation
import RealmSwift

protocol DetailViewModelProtocol: AnyObject {
    var id: Int? { get set }
    var films: DetailModel? { get set }
    var reloadData: VoidHandler? { get set }
    func getDetailMovie()
}

final class DetailViewModel: DetailViewModelProtocol {
    // MARK: - Public Properties

    var id: Int?
    var films: DetailModel?
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
        let movieDetailRealm = repository?.get(
            type: DetailModel.self,
            column: "movieID",
            movieID: id
        )
        var detail: DetailModel?
        movieDetailRealm?.forEach { details in
            detail = details
        }
        films = detail

        if films == nil {
            movieAPIService.getDetailRated(id: id, complition: { [weak self] result in
                guard let self = self else { return }
                switch result {
                case let .failure(error):
                    print(error.localizedDescription)
                case let .success(movieDetailRealm):
                    self.films = movieDetailRealm
                    self.films?.movieID = String(self.id ?? 0)

                    DispatchQueue.main.async {
                        self.reloadData?()
                        self.repository?.save(object: [movieDetailRealm])
                    }
                }
            })
        }
    }
}
