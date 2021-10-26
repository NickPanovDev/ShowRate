// RealmProvider.swift
// Copyright © Movie. All rights reserved.

import Foundation
import RealmSwift

protocol RealmProviderProtocol {
    func saveToRealm<T: Object>(object: [T])
    func loadingDetail<T>(type: T.Type, column: String?, movieID: Int?) -> Results<T>? where T: Object
    func loadingMovie<T: Object>(type: T.Type) -> Results<T>?
    func deleteRealm<T: Object>(results: Results<T>)
}

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

    func loadingDetail<T>(type: T.Type, column: String? = nil, movieID: Int? = nil) -> Results<T>? where T: Object {
        if column != nil {
            guard let column = column,
                  let movieID = movieID else { return nil }
            let predicate = NSPredicate(format: "\(column) == %@", String(movieID))
            let realm = try? Realm()
            let movieDetailRealm = realm?.objects(type).filter(predicate)
            return movieDetailRealm
        } else {
            let realm = try? Realm(configuration: config)
            guard let results = realm?.objects(type) else { return nil }
            return results
        }
    }

    func loadingMovie<T: Object>(type: T.Type) -> Results<T>? {
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
