// MainCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class MainCoordinator: BaseCoordinator {
    // MARK: - Public Properties

    var navigationController: UINavigationController?
    var assemblyModule: AssemblyModuleProtocol?
    var onFinishFlow: (() -> ())?

    // MARK: - Initializers

    init(navigationController: UINavigationController, assemblyModule: AssemblyModuleProtocol) {
        self.navigationController = navigationController
        self.assemblyModule = assemblyModule
    }

    override func start() {
        showMovieModule()
    }

    // MARK: - Public Methods

    func showDetail(movieID: Int?) {
        guard let detailViewController = assemblyModule?.createDetailModule(movieID: movieID)
        else { return }
        navigationController?.pushViewController(detailViewController, animated: true)
    }

    // MARK: - Private Methods

    private func showMovieModule() {
        guard let movieVC = assemblyModule?.createMainModule() as? MainTableViewController else { return }

        movieVC.showDetails = { [weak self] movieID in
            guard let self = self else { return }
            self.showDetail(movieID: movieID)
        }
        if navigationController == nil {
            let navController = UINavigationController(rootViewController: movieVC)
            navigationController = navController
            setAsRoot(navController)
        } else if let navigationController = navigationController {
            navigationController.pushViewController(movieVC, animated: true)
            setAsRoot(navigationController)
        }
    }
}
