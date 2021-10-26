// Repository.swift
// Copyright © Movie. All rights reserved.

import Foundation
import RealmSwift

protocol RepositoryProtocol {
    func save<T: Object>(object: [T])
    func get<T>(type: T.Type, column: String?, movieID: Int?) -> Results<T>? where T: Object
    func get<T: Object>(type: T.Type) -> Results<T>?
    func delete<T: Object>(results: Results<T>)
}

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

    func get<T>(type: T.Type, column: String?, movieID: Int?) -> Results<T>? where T: Object {
        realmProvider?.loadingDetail(type: type, column: column, movieID: movieID)
    }

    func get<T>(type: T.Type) -> Results<T>? where T: Object {
        realmProvider?.loadingMovie(type: type)
    }

    func delete<T>(results: Results<T>) where T: Object {
        realmProvider?.deleteRealm(results: results)
    }
}
