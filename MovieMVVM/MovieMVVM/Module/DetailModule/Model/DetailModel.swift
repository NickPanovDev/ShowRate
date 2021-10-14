// DetailModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// DetailModel
final class DetailModel: Object, Decodable {
    /// Название фильма
    @objc dynamic var title: String
    /// Описание фильма
    @objc dynamic var overview: String
    /// Постер фильма
    @objc dynamic var posterPath: String
}
