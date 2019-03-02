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
    func getNextUpcomingMovie()
}

class UpcomingMoviesInteractor: UpcomingMoviesInteractorProtocol {
    private var presenter: UpcomingMoviesPresenterProtocol?
    private var worker: UpcomingMoviesWorker?
    private var upcomingMoviesData: [Movie] = []
    private var isWaitingResponse: Bool = false
    private var currentPage: Int = 0
    private var totalPages: Int = 0
    
    init(presenter: UpcomingMoviesPresenterProtocol, worker: UpcomingMoviesWorker = UpcomingMoviesWorker()) {
        self.presenter = presenter
        self.worker = worker
    }
    
    func getUpcomingMovies() {
        currentPage = 1
        presenter?.presentLoadingView()
        worker?.getUpcomingMovies(page: currentPage, success: { result in
            
            self.totalPages = result.totalPages
            self.upcomingMoviesData.append(contentsOf: result.movies)
            let viewModel = self.treatUpcomingMoviesData(movies: result.movies)
            self.presenter?.closeLoadingView()
            self.presenter?.presentUpcomingMovies(movies: viewModel)
            
        }, failure: { error in
            
            self.presenter?.closeLoadingView()
            self.presenter?.presentError(message: error.localizedDescription)
            
        })
    }
    
    func getNextUpcomingMovie() {
        if !isWaitingResponse {
            currentPage += 1
            if currentPage <= totalPages {
                isWaitingResponse = true
                presenter?.presentFooterLoading()
                worker?.getUpcomingMovies(page: currentPage, success: { result in
                    self.isWaitingResponse = false
                    self.presenter?.closeFooterLoading()
                    self.upcomingMoviesData.append(contentsOf: result.movies)
                    let viewModel = self.treatUpcomingMoviesData(movies: self.upcomingMoviesData)
                    self.presenter?.presentUpcomingMovies(movies: viewModel)
                }, failure: { error in
                    self.isWaitingResponse = false
                    self.presenter?.closeLoadingView()
                    self.presenter?.presentError(message: error.localizedDescription)
                })
            }
        }
    }
    
    private func treatUpcomingMoviesData(movies: [Movie]) -> [UpcomingMoviesViewModel] {
        
        return movies.map { UpcomingMoviesViewModel(genreIds: $0.genreIDS,
                                                    poster: $0.posterPath,
                                                    backdrop: $0.backdropPath ?? "",                                                    movieName: $0.title,
                                                    releaseDate: $0.releaseDate.formatString())}
    }
}
