// MovieMVVMUITests.swift
// Copyright © RoadMap. All rights reserved.

import XCTest

/// MovieMVVMUITests
class MovieMVVMUITests: XCTestCase {
    var application: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        application = XCUIApplication()
        application.launch()
    }

    override func tearDownWithError() throws {}

    func testExample() throws {
        let tableViewModel = application.tables["MainTableViewController"]
        tableViewModel.swipeUp()
        let tapOnCell = tableViewModel.cells.element(boundBy: 7)
        tapOnCell.tap()
        RunLoop.current.run(until: Date(timeInterval: 2, since: Date()))
        let detailViewLabel = application.staticTexts["titleLabel"]
        XCTAssertTrue(!detailViewLabel.label.isEmpty)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
