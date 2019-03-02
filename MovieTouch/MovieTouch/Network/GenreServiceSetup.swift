//
//  GenreServiceSetup.swift
//  MovieTouch
//
//  Created by Thiago Santiago on 3/1/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation

enum GenreServiceSetup: MovieTouchApiSetupProtocol {
    
    case fetchMoviesGenre()
    
    var endpoint: String {
        switch self {
            
        case .fetchMoviesGenre():
            let url = Constants.baseUrl + "/genre/movie/list?api_key=\(Constants.apiKey)&language=pt-BR"
            
            return url
        }
    }
}
