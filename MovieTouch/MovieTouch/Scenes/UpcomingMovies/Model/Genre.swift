//
//  Genre.swift
//  MovieTouch
//
//  Created by Thiago Santiago on 3/1/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation

struct Genre {
    let id: Int
    let name: String
}

extension Genre: Decodable {}

extension Genre: Equatable {
    static func == (lhs: Genre, rhs: Genre) -> Bool {
        return lhs.id == rhs.id &&
               lhs.name == rhs.name
    }
}
