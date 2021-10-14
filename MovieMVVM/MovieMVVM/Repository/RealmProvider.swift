// RealmProvider.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// RealmProviderProtocol
protocol RealmProviderProtocol {
    func saveToRealm<T: Object>(object: [T])
    func saveSingleToRealm<T: Object>(object: T)
    func loadingRealm<T: Object>(type: T.Type) -> Results<T>?
    func deleteRealm<T: Object>(results: Results<T>)
}

/// RealmProvider
final class RealmProvider: RealmProviderProtocol {
    // MARK: - Private Properties

    private let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)

    // MARK: - Public Methods

    func saveToRealm<T: Object>(object: [T]) {
        do {
            let realm = try Realm(configuration: config)
            realm.beginWrite()
            realm.add(object, update: .modified)
            try realm.commitWrite()
        } catch {
            print(error.localizedDescription)
        }
    }

    func saveSingleToRealm<T: Object>(object: T) {
        do {
            let realm = try Realm(configuration: config)
            realm.beginWrite()
            realm.add(object)
            try realm.commitWrite()
        } catch {
            print(error.localizedDescription)
        }
    }

    func loadingRealm<T: Object>(type: T.Type) -> Results<T>? {
        do {
            let realm = try Realm(configuration: config)
            return realm.objects(type)
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }

    func deleteRealm<T: Object>(results: Results<T>) {
        do {
            let realm = try Realm(configuration: config)
            try realm.write {
                realm.delete(results)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
