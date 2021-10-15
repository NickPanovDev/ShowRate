// AssemblyModule.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// AssemblyModuleProtocol
protocol AssemblyModuleProtocol {
    func createMainModule() -> UITableViewController
    func createDetailModule(movieID: Int?) -> UITableViewController
}

/// AssemblyModule
final class AssemblyModule: AssemblyModuleProtocol {
    // MARK: - Public Methods

    func createMainModule() -> UITableViewController {
        let view = MainTableViewController()
        let movieAPIService = MovieAPIService()
        let realmProvider = RealmProvider()
        let repository = RealmRepository(realmProvider: realmProvider)
        let viewModel = MovieViewModel(movieAPIService: movieAPIService, repositoryProtocol: repository)
        view.movieViewModel = viewModel
        return view
    }

    func createDetailModule(movieID: Int?) -> UITableViewController {
        let view = DetailTableViewController()
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
