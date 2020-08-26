//
//  UpcomingMoviesWorker.swift
//  MovieTouch
//
//  Created by Thiago Santiago on 3/1/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation

class UpcomingMoviesWorker {
    typealias Failure = (_ error: MovieTouchApiError) -> Void
    
    let requester: MovieTouchApiRequestProtocol

    init(requester: MovieTouchApiRequestProtocol = MovieTouchApiRequest()) {
        self.requester = requester
    }
    
    typealias GetUpcomingMoviesSuccess = (_ movies: UpcomingMovies) -> Void
    func getUpcomingMovies(page: Int, success: @escaping GetUpcomingMoviesSuccess, failure: @escaping Failure) {
        
        requester.request(UpcomingMoviesServiceSetup.fetchUpcomingMovies(page: page)) { result in
            switch result{
            case let .success(data):

                do {
                    let decoder = JSONDecoder()
                    let moviesList = try decoder.decode(UpcomingMovies.self, from: data)
                    
                    success(moviesList)
                } catch {
                    failure(.couldNotParseObject)
                }
            case let .failure(error):
                failure(error)
            }
        }
    }
    
    typealias GetGenresSuccess = (_ genres: Genres) -> Void
    func getMovieGenres(success: @escaping GetGenresSuccess, failure: @escaping Failure) {
        
        requester.request(GenreServiceSetup.fetchMoviesGenre()) { result in
            switch result {
            case let .success(data):
                
                do {
                    let decoder = JSONDecoder()
                    let genresList = try decoder.decode(Genres.self, from: data)
                    
                    success(genresList)
                } catch {
                    failure(.couldNotParseObject)
                }
            case let .failure(error) :
                failure(error)
            }
        }
    }
    
    typealias SearchMoviesSuccess = (_ movies: UpcomingMovies) -> Void
    func searchMovies(text: String, page: Int, success: @escaping SearchMoviesSuccess, failure: @escaping Failure) {
        guard let urlString = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            failure(.unknown("Can't convert the text."))
            return
        }
        
        requester.request(SearchMovieServiceSetup.searchMovies(text: urlString, page: page)) { result in
            switch result {
                
            case let .success(data):
                
                do {
                    let decoder = JSONDecoder()
                    let moviesList = try decoder.decode(UpcomingMovies.self, from: data)
                    
                    success(moviesList)
                } catch {
                    failure(.couldNotParseObject)
                }
            case let .failure(error):
                failure(error)
            }
        }
    }
}
