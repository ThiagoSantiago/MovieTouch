//
//  UpcomingMoviesWorker.swift
//  MovieTouch
//
//  Created by Thiago Santiago on 3/1/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation

class UpcomingMoviesWorker {
    let requester: MovieTouchApiRequestProtocol
    
    typealias Failure = (_ error: MovieTouchApiError) -> Void
    typealias GetUpcomingMoviesSuccess = (_ repositories: UpcomingMovies) -> Void
    
    init(requester: MovieTouchApiRequestProtocol = MovieTouchApiRequest()) {
        self.requester = requester
    }
    
    func getUpcomingMovies(page: Int, success: @escaping GetUpcomingMoviesSuccess, failure: @escaping Failure) {
        
        requester.request(UpcomingMoviesServiceSetup.fetchUpcomingMovies(page: page)) { (result) in
            switch result{
            case let .success(data):

                do {
                    let decoder = JSONDecoder()
                    let repositoriesList = try decoder.decode(UpcomingMovies.self, from: data)
                    
                    success(repositoriesList)
                } catch {
                    failure(.couldNotParseObject)
                }
            case let .failure(error):
                failure(error)
            }
        }
    }
}
