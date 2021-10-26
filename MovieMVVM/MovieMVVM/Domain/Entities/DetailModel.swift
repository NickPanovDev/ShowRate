// DetailModel.swift
// Copyright © Movie. All rights reserved.

import Foundation
import RealmSwift

/// Информация о конкретном фильме
final class DetailModel: Object, Decodable {
    /// Название фильма
    @objc dynamic var title: String
    /// Описание фильма
    @objc dynamic var overview: String
    /// Постер фильма
    @objc dynamic var posterPath: String
    /// ID
    @objc dynamic var movieID: String?

    override static func primaryKey() -> String? {
        "movieID"
    }
}
