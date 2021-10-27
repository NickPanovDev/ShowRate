// RealmTest.swift
// Copyright © ShowRate. All rights reserved.

@testable import MovieMVVM
import RealmSwift
import XCTest

/// MockModel
final class MockModel: Object {
    @objc dynamic var title = "Baz"
    @objc dynamic var date = "Bar"

    override static func primaryKey() -> String? {
        "date"
    }
}

/// RealmTest
final class RealmTest: XCTestCase {
    var repository: RepositoryProtocol!

    override func setUpWithError() throws {
        repository = RealmRepository(realmProvider: RealmProvider())
    }

    override func tearDownWithError() throws {}

    func testRealm() {
        let mockModel = MockModel()
        var mockObjects: [MockModel] = []
        mockObjects.append(mockModel)
        repository.save(object: mockObjects)
        guard let objectsFromRealm = repository.get(type: MockModel.self) else { return }
        repository.delete(results: objectsFromRealm)
        XCTAssertNotNil(objectsFromRealm)
    }
}
