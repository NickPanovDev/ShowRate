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
        let viewModel = MovieViewModel(movieAPIService: movieAPIService)
        view.movieViewModel = viewModel
        return view
    }

    func createDetailModule(movieID: Int?) -> UITableViewController {
        let view = DetailTableViewController()
        let movieAPIService = MovieAPIService()
        let viewModel = DetailViewModel(movieAPIService: movieAPIService, id: movieID)
        view.detailViewModel = viewModel
        return view
    }
}
