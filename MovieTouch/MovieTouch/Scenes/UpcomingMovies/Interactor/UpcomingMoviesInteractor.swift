//
//  UpcomingMoviesInteractor.swift
//  MovieTouch
//
//  Created by Thiago Santiago on 3/1/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation

protocol UpcomingMoviesInteractorProtocol {
    func getUpcomingMovies()
}

class UpcomingMoviesInteractor: UpcomingMoviesInteractorProtocol {
    private var presenter: UpcomingMoviesPresenterProtocol?
    private var worker: UpcomingMoviesWorker?
    private var totalPages: Int = 0
    
    init(presenter: UpcomingMoviesPresenterProtocol, worker: UpcomingMoviesWorker = UpcomingMoviesWorker()) {
        self.presenter = presenter
        self.worker = worker
    }
    
    func getUpcomingMovies() {
        presenter?.presentLoadingView()
        worker?.getUpcomingMovies(success: { result in
            self.totalPages = result.totalPages
            let viewModel = result.movies.map { UpcomingMoviesViewModel(genreIds: $0.genreIDS,
                                                                        poster: $0.posterPath,
                                                                        backdrop: $0.backdropPath,
                                                                        movieName: $0.title,
                                                                        releaseDate: $0.releaseDate.formatString())}
            
            self.presenter?.closeLoadingView()
            self.presenter?.presentUpcomingMovies(movies: viewModel)
        }, failure: { error in
            self.presenter?.closeLoadingView()
            self.presenter?.presentError(message: error.localizedDescription)
        })
    }
}
