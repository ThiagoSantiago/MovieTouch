//
//  UpcomingMoviesViewModel.swift
//  MovieTouch
//
//  Created by Thiago Santiago on 3/1/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation

struct UpcomingMoviesViewModel {
    let genres: String
    let poster: String
    let backdrop: String
    let overview: String
    let movieName: String
    let releaseDate: String
}

extension UpcomingMoviesViewModel: Equatable {
    static func ==(lhs: UpcomingMoviesViewModel, rhs: UpcomingMoviesViewModel) -> Bool {
        return lhs.genres == rhs.genres &&
            lhs.poster == rhs.poster &&
            lhs.backdrop == rhs.backdrop &&
            lhs.overview == rhs.overview &&
            lhs.movieName == rhs.movieName &&
            lhs.releaseDate == rhs.releaseDate
    }
}
