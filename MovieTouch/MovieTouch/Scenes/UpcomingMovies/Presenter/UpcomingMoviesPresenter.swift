//
//  UpcomingMoviesPresenter.swift
//  MovieTouch
//
//  Created by Thiago Santiago on 3/1/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation


protocol UpcomingMoviesPresenterProtocol {
    func closeLoadingView(isNextPage: Bool)
    func presentLoadingView(isNextPage: Bool)
    func presentError(message: String, isSearching: Bool)
    func presentUpcomingMovies(movies: [UpcomingMoviesViewModel])
}

class UpcomingMoviesPresenter: UpcomingMoviesPresenterProtocol {
    weak var viewController: UpcomingMoviesProtocol?
    
    func closeLoadingView(isNextPage: Bool = false) {
        DispatchQueue.main.async {
            if isNextPage {
                self.viewController?.hideFooterLoading()
            } else {
                self.viewController?.hideLoadingView()
            }
        }
    }
    
    func presentLoadingView(isNextPage: Bool = false) {
        if isNextPage {
            viewController?.displayFooterLoading()
        } else {
            viewController?.displayLoadingView()
        }
        
    }
    
    func presentError(message: String, isSearching: Bool) {
        DispatchQueue.main.async {
            self.viewController?.displayError(message, hideButton: isSearching)
        }
        
    }
    
    func presentUpcomingMovies(movies: [UpcomingMoviesViewModel]) {
        DispatchQueue.main.async {
            self.viewController?.displayUpcomingMovies(movies)
        }
    }
    
    
}
