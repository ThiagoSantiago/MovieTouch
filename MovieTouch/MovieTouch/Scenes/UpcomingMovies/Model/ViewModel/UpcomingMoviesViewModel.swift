//
//  UpcomingMoviesViewModel.swift
//  MovieTouch
//
//  Created by Thiago Santiago on 3/1/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation

struct UpcomingMoviesViewModel {
    let genreIds: [Int]
    let poster: String
    let backdrop: String
    let movieName: String
    let releaseDate: String
}

extension UpcomingMoviesViewModel: Equatable {
    static func ==(lhs: UpcomingMoviesViewModel, rhs: UpcomingMoviesViewModel) -> Bool {
        return lhs.genreIds == rhs.genreIds &&
            lhs.poster == rhs.poster &&
            lhs.backdrop == rhs.backdrop &&
            lhs.movieName == rhs.movieName &&
            lhs.releaseDate == rhs.releaseDate
    }
}
