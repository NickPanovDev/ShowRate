// CoordinatorTests.swift
// Copyright © Movie. All rights reserved.

@testable import MovieMVVM
import UIKit
import XCTest

final class MockNavigationController: UINavigationController {
    var presentedVC: UIViewController?

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        presentedVC = viewController
        super.pushViewController(viewController, animated: animated)
    }
}

final class CoordinatorTests: XCTestCase {
    var appplicationCoordinator: ApplicationCoordinator!
    var navigationController: MockNavigationController!
    var assemblyModule: AssemblyModuleProtocol!

    override func setUpWithError() throws {
        navigationController = MockNavigationController()
        assemblyModule = AssemblyModule()
        appplicationCoordinator = ApplicationCoordinator(
            navigationController: navigationController,
            assemblyModule: assemblyModule
        )
    }

    override func tearDownWithError() throws {
        navigationController = nil
        assemblyModule = nil
        appplicationCoordinator = nil
    }

    func testPresentedMovie() throws {
        appplicationCoordinator.start()
        let movieVC = navigationController.presentedVC
        XCTAssertTrue(movieVC is MainTableViewController)
    }

    func testPresentedDetails() throws {
        appplicationCoordinator.start()
        guard let movieVC = navigationController.presentedVC as? MainTableViewController else { return }
        movieVC.showDetails?(Int())
        let detailsVC = navigationController.presentedVC
        XCTAssertTrue(detailsVC is DetailTableViewController)
    }
}
