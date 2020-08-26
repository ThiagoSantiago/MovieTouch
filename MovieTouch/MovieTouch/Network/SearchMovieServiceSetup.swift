//
//  SearchMovieServiceSetup.swift
//  MovieTouch
//
//  Created by Thiago Santiago on 3/2/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation

enum SearchMovieServiceSetup: MovieTouchApiSetupProtocol {
    
    case searchMovies(text: String, page: Int)
    
    var endpoint: String {
        switch self {
        case .searchMovies(let text, let page):
            let url = Constants.baseUrl + "/search/movie?api_key=\(Constants.apiKey)&language=en-US&query=\(text)&page=\(page)&include_adult=false"
            
            return url
        }
    }
}
