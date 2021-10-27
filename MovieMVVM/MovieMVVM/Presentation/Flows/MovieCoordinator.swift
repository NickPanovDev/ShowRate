// MovieCoordinator.swift
// Copyright © ShowRate. All rights reserved.

import UIKit

final class MovieCoordinator: BaseCoordinator {
    // MARK: - Public Properties

    private var navigationController: UINavigationController?
    private var assemblyModule: AssemblyModuleProtocol?
    var onFinishFlow: VoidHandler?

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
        navigationController?.pushViewController(movieVC, animated: true)
        guard let navigationController = navigationController else { return }
        setAsRoot(navigationController)
    }
}
