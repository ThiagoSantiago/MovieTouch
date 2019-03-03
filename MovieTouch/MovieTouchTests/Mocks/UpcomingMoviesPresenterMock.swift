//
//  UpcomingMoviesPresenterMock.swift
//  MovieTouchTests
//
//  Created by Thiago Santiago on 3/2/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

@testable import MovieTouch

class UpcomingMoviesPresenterMock: UpcomingMoviesPresenter {
    var viewModel: [UpcomingMoviesViewModel]?
    var loadingPresented: Bool = false
    var errorWasPresented: Bool = false
    var moviesListPresented: Bool = false
    var closeLoadingPresented: Bool = false
    var footerLoadingPresented: Bool = false
    var closeFooterLoadingPresented: Bool = false
    
    
    override func presentLoadingView(isNextPage: Bool) {
        if isNextPage {
            footerLoadingPresented = true
        } else {
            loadingPresented = true
        }
    }
    
    override func closeLoadingView(isNextPage: Bool) {
        if isNextPage {
            closeFooterLoadingPresented = true
        } else {
            closeLoadingPresented = true
        }
    }
    
    override func presentError(message: String) {
        errorWasPresented = true
    }
    
    override func presentUpcomingMovies(movies: [UpcomingMoviesViewModel]) {
        viewModel = movies
        moviesListPresented = true
    }
}
