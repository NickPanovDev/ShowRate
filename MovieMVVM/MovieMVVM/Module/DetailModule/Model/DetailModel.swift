// DetailModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// DetailModel
struct DetailModel: Codable {
    /// Название фильма
    var title: String
    /// Описание фильма
    var overview: String
    /// Постер фильма
    var posterPath: String
}
