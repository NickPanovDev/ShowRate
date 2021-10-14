// Repository.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// RepositoryProtocol
protocol RepositoryProtocol {
    func save<T: Object>(object: [T])
    func saveSingle<T: Object>(object: T)
    func get<T: Object>(type: T.Type) -> Results<T>?
    func delete<T: Object>(results: Results<T>)
}

/// RealmRepository
final class RealmRepository: RepositoryProtocol {
    // MARK: - Private Properties

    private let realmProvider: RealmProviderProtocol?

    init(realmProvider: RealmProviderProtocol) {
        self.realmProvider = realmProvider
    }

    // MARK: - Public Methods

    func save<T>(object: [T]) where T: Object {
        realmProvider?.saveToRealm(object: object)
    }

    func saveSingle<T>(object: T) where T: Object {
        realmProvider?.saveSingleToRealm(object: object)
    }

    func get<T>(type: T.Type) -> Results<T>? where T: Object {
        realmProvider?.loadingRealm(type: type)
    }

    func delete<T>(results: Results<T>) where T: Object {
        realmProvider?.deleteRealm(results: results)
    }
}
