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
    func closeFooterLoading()
    func presentFooterLoading()
    func presentError(message: String)
    func presentUpcomingMovies(movies: [UpcomingMoviesViewModel])
}

class UpcomingMoviesPresenter: UpcomingMoviesPresenterProtocol {
    weak var viewController: UpcomingMoviesProtocol?
    
    func closeLoadingView() {
        DispatchQueue.main.async {
            self.viewController?.hideLoadingView()
        }
    }
    
    func presentLoadingView() {
        viewController?.displayLoadingView()
    }
    
    func closeFooterLoading() {
        DispatchQueue.main.async {
            self.viewController?.hideFooterLoading()
        }
    }
    
    func presentFooterLoading() {
        viewController?.displayFooterLoading()
    }
    
    func presentError(message: String) {
        DispatchQueue.main.async {
            self.viewController?.displayError(message)
        }
        
    }
    
    func presentUpcomingMovies(movies: [UpcomingMoviesViewModel]) {
        DispatchQueue.main.async {
            self.viewController?.displayUpcomingMovies(movies)
        }
    }
    
    
}
