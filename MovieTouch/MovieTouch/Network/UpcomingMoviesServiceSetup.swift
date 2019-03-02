//
//  UpcomingMoviesServiceSetup.swift
//  MovieTouch
//
//  Created by Thiago Santiago on 3/1/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation


enum UpcomingMoviesServiceSetup: MovieTouchApiSetupProtocol {
    
    case fetchUpcomingMovies(page: Int)
    
    var endpoint: String {
        switch self {
            
        case .fetchUpcomingMovies(let page):
            let url = Constants.baseUrl + "/movie/upcoming?api_key=\(Constants.apiKey)&language=en-US&page=\(page)"
            
            return url
        }
    }
}
