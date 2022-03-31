// AssemblyModule.swift
// Copyright © ShowRate. All rights reserved.

import UIKit

protocol AssemblyModuleProtocol {
    func createMainModule() -> UIViewController
    func createDetailModule(movieID: Int?) -> UIViewController
}

final class AssemblyModule: AssemblyModuleProtocol {
    // MARK: - Public Methods

    func createMainModule() -> UIViewController {
        let view = MainViewController()
        let movieAPIService = MovieAPIService()
        let realmProvider = RealmProvider()
        let repository = RealmRepository(realmProvider: realmProvider)
        let viewModel = MovieViewModel(movieAPIService: movieAPIService, repositoryProtocol: repository)
        view.movieViewModel = viewModel
        return view
    }

    func createDetailModule(movieID: Int?) -> UIViewController {
        let view = DetailViewController()
        let movieAPIService = MovieAPIService()
        let realmProvider = RealmProvider()
        let repository = RealmRepository(realmProvider: realmProvider)
        let viewModel = DetailViewModel(
            movieAPIService: movieAPIService,
            id: movieID,
            repositoryProtocol: repository
        )
        view.detailViewModel = viewModel
        return view
    }
}
