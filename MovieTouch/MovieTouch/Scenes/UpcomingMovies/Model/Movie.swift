//
//  Movie.swift
//  MovieTouch
//
//  Created by Thiago Santiago on 3/1/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation

struct Movie {
    let id: Int
    let voteCount: Int
    let video: Bool
    let voteAverage: Double
    let title: String
    let popularity: Double
    let posterPath: String?
    let originalTitle: String
    let genreIDS: [Int]
    let backdropPath: String?
    let adult: Bool
    let overview: String
    let releaseDate: String
}

extension Movie: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case video
        case adult
        case overview
        case title
        case popularity
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(Int.self, forKey: .id)
        video = try values.decode(Bool.self, forKey: .video)
        adult = try values.decode(Bool.self, forKey: .adult)
        overview = try values.decode(String.self, forKey: .overview)
        title = try values.decode(String.self, forKey: .title)
        popularity = try values.decode(Double.self, forKey: .popularity)
        voteCount = try values.decode(Int.self, forKey: .voteCount)
        voteAverage = try values.decode(Double.self, forKey: .voteAverage)
        posterPath = try? values.decode(String.self, forKey: .posterPath)
        originalTitle = try values.decode(String.self, forKey: .originalTitle)
        genreIDS = try values.decode([Int].self, forKey: .genreIDS)
        backdropPath = try? values.decode(String.self, forKey: .backdropPath)
        releaseDate = try values.decode(String.self, forKey: .releaseDate)
    }
}

extension Movie: Equatable {
    static func ==(lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id &&
            lhs.video == rhs.video &&
            lhs.adult == rhs.adult &&
            lhs.overview == rhs.overview &&
            lhs.title == rhs.title &&
            lhs.popularity == rhs.popularity &&
            lhs.voteCount == rhs.voteCount &&
            lhs.voteAverage == rhs.voteAverage &&
            lhs.posterPath == rhs.posterPath &&
            lhs.originalTitle == rhs.originalTitle &&
            lhs.genreIDS == rhs.genreIDS &&
            lhs.backdropPath == rhs.backdropPath &&
            lhs.releaseDate == rhs.releaseDate
    }
}
