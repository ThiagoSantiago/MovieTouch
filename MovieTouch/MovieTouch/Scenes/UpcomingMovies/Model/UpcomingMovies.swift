//
//  UpcomingMovies.swift
//  MovieTouch
//
//  Created by Thiago Santiago on 3/1/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation

struct UpcomingMovies {
    let movies: [Movie]
    let page: Int
    let totalResults: Int
    let totalPages: Int
}

extension UpcomingMovies: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case page
        case movies = "results"
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        movies = try values.decode([Movie].self, forKey: .movies)
        page = try values.decode(Int.self, forKey: .page)
        totalResults = try values.decode(Int.self, forKey: .totalResults)
        totalPages = try values.decode(Int.self, forKey: .totalPages)
    }
}

extension UpcomingMovies: Equatable {
    static func ==(lhs: UpcomingMovies, rhs: UpcomingMovies) -> Bool {
        return lhs.movies == rhs.movies &&
            lhs.page == rhs.page &&
            lhs.totalResults == rhs.totalResults &&
            lhs.totalPages == rhs.totalPages
    }
}

