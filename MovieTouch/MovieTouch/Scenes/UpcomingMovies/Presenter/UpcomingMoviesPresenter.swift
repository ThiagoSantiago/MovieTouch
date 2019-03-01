//
//  UpcomingMoviesPresenter.swift
//  MovieTouch
//
//  Created by Thiago Santiago on 3/1/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation


protocol UpcomingMoviesPresenterProtocol {
    func closeLoadingView()
    func presentLoadingView()
    func presentError(message: String)
    func presentUpcomingMovies(movies: [UpcomingMoviesViewModel])
}

class UpcomingMoviesPresenter: UpcomingMoviesPresenterProtocol {
    var viewController: UpcomingMoviesProtocol?
    
    func closeLoadingView() {
        viewController?.hideLoadingView()
    }
    
    func presentLoadingView() {
        viewController?.displayLoadingView()
    }
    
    func presentError(message: String) {
        viewController?.displayError(message)
    }
    
    func presentUpcomingMovies(movies: [UpcomingMoviesViewModel]) {
        DispatchQueue.main.async {
            self.viewController?.displayUpcomingMovies(movies)
        }
    }
    
    
}
