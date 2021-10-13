// SceneDelegate.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// SceneDelegate
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var coordinator: ApplicationCoordinator?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        window.makeKeyAndVisible()
        self.window = window
        let navController = UINavigationController()
        coordinator = ApplicationCoordinator(navigationController: navController, assemblyBuilder: AssemblyModule())
        coordinator?.start()
//        let movieAPIService = MovieAPIService()
//        let movieViewModel = MovieViewModel(movieAPIService: movieAPIService)
//        let mainVC = MainTableViewController(view: movieViewModel)
//        let navController = UINavigationController(rootViewController: mainVC)
//        window?.rootViewController = navController
//        window?.makeKeyAndVisible()

//        let navController = UINavigationController()
//        let assemblyBuilder = AssemblyModule()
//        coordinator = ApplicationCoordinator()
//        coordinator?.start()
//        window?.rootViewController = navController
//        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}
