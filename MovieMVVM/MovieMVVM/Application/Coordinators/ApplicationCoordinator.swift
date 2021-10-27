// ApplicationCoordinator.swift
// Copyright © ShowRate. All rights reserved.

import UIKit

final class ApplicationCoordinator: BaseCoordinator {
    // MARK: - Public Properties

    private var navigationController: UINavigationController
    private var assemblyModule: AssemblyModuleProtocol

    // MARK: - Initializers

    init(navigationController: UINavigationController, assemblyModule: AssemblyModuleProtocol) {
        self.navigationController = navigationController
        self.assemblyModule = assemblyModule
    }

    override func start() {
        toMain()
    }

    // MARK: - Private Methods

    private func toMain() {
        let coordinator = MovieCoordinator(navigationController: navigationController, assemblyModule: assemblyModule)

        coordinator.onFinishFlow = { [weak self, weak coordinator] in
            guard let self = self else { return }
            self.removeDependency(coordinator)
            self.start()
        }
        addDependency(coordinator)
        coordinator.start()
    }
}
