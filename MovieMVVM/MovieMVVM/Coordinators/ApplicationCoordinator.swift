// ApplicationCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class ApplicationCoordinator: BaseCoordinator {
    // MARK: - Public Properties

    var navigationController: UINavigationController
    var assemblyModule: AssemblyModuleProtocol

    // MARK: - Initializers

    init(navigationController: UINavigationController, assemblyBuilder: AssemblyModuleProtocol) {
        self.navigationController = navigationController
        assemblyModule = assemblyBuilder
    }

    override func start() {
        toMain()
    }

    // MARK: - Private Methods

    private func toMain() {
        let coordinator = MainCoordinator(navigationController: navigationController, assemblyModule: assemblyModule)

        coordinator.onFinishFlow = { [weak self, weak coordinator] in
            guard let self = self else { return }
            self.removeDependency(coordinator)
            self.start()
        }
        addDependency(coordinator)
        coordinator.start()
    }
}
