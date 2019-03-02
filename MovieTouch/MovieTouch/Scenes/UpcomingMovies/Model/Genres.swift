//
//  Genres.swift
//  MovieTouch
//
//  Created by Thiago Santiago on 3/1/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation

struct Genres {
    let genres: [Genre]
}

extension Genres: Decodable {}

extension Genres: Equatable {
    static func == (lhs: Genres, rhs: Genres) -> Bool {
        return lhs.genres == rhs.genres
    }
}
