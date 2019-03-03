//
//  UpcomingMoviesInteractor.swift
//  MovieTouch
//
//  Created by Thiago Santiago on 3/1/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation

protocol UpcomingMoviesInteractorProtocol {
    func getGenres()
    func getUpcomingMovies()
    func getNextUpcomingMovie()
}

class UpcomingMoviesInteractor: UpcomingMoviesInteractorProtocol {
    typealias Cache = (page: Int, totalPages: Int, movies: [Movie])
    private var presenter: UpcomingMoviesPresenterProtocol?
    private var worker: UpcomingMoviesWorker?
    
    private var moviesData: [Movie] = []
    private var genres:[Int:String] = [:]
    private var isWaitingResponse: Bool = false
    
    private var currentPage: Int = 0
    private var totalPages: Int = 0
    private var isNextPage: Bool = false
    
    private var isSearching: Bool = false
    private var textToSearch: String = ""
    private var cacheData: Cache  = Cache(page: 0, totalPages: 0, movies: [])
    
    init(presenter: UpcomingMoviesPresenterProtocol, worker: UpcomingMoviesWorker = UpcomingMoviesWorker()) {
        self.presenter = presenter
        self.worker = worker
    }
    
    func getGenres() {
        worker?.getMovieGenres(success: { result in
            self.genres = result.genres.reduce([Int:String](), { (dict, genre) -> [Int: String] in
                var dict = dict
                dict[genre.id] = genre.name
                return dict
            })
        }, failure: { error in
            self.manageError(with: error)
        })
    }
    
    func getUpcomingMovies() {
        currentPage = 1
        presenter?.presentLoadingView(isNextPage: isNextPage)
        if verifyGenres() {
            worker?.getUpcomingMovies(page: currentPage, success: { result in
                self.manageSuccess(with: result)
            }, failure: { error in
                self.manageError(with: error)
            })
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                self.getUpcomingMovies()
            })
        }
    }
    
    func getNextUpcomingMovie() {
        isNextPage = true
        if isSearching {
            nextFilteredPage()
        } else {
            if !isWaitingResponse {
                currentPage += 1
                if currentPage <= totalPages {
                    isWaitingResponse = true
                    presenter?.presentLoadingView(isNextPage: isNextPage)
                    worker?.getUpcomingMovies(page: currentPage, success: { result in
                        self.isWaitingResponse = false
                        self.manageSuccess(with: result)
                    }, failure: { error in
                        self.isWaitingResponse = false
                        self.manageError(with: error)
                    })
                }
            }
        }
    }
    
    func searchMovies(text: String) {
        startSearching()
        textToSearch = text
        currentPage += 1
        
        presenter?.presentLoadingView(isNextPage: isNextPage)
        worker?.searchMovies(text: text, page: currentPage, success: { result in
            self.manageSuccess(with: result)
        }, failure: { error in
            self.manageError(with: error)
        })
    }
    
    func nextFilteredPage() {
        isNextPage = true
        if !isWaitingResponse {
            currentPage += 1
            if currentPage <= totalPages {
                isWaitingResponse = true
                presenter?.presentLoadingView(isNextPage: isNextPage)
                worker?.searchMovies(text: textToSearch, page: currentPage, success: { result in
                    self.isWaitingResponse = false
                    self.manageSuccess(with: result)
                }, failure: { error in
                    self.isWaitingResponse = false
                    self.manageError(with: error)
                })
            }
        }
    }
    
    func cancelSearch() {
        self.isSearching = false
        self.retrieveCachedContent()
        let viewModel = self.treatUpcomingMoviesData(movies: self.moviesData)
        self.presenter?.presentUpcomingMovies(movies: viewModel)
    }
    
    private func retrieveCachedContent() {
        currentPage = cacheData.page
        totalPages = cacheData.totalPages
        moviesData = cacheData.movies
    }
    
    private func verifyGenres() ->  Bool {
        if self.genres.isEmpty {
            self.getGenres()
            return false
        } else {
            return true
        }
    }
    
    private func manageSuccess(with result: UpcomingMovies){
        self.totalPages = result.totalPages
        self.moviesData.append(contentsOf: result.movies)
        let viewModel = self.treatUpcomingMoviesData(movies: self.moviesData)
        self.presenter?.closeLoadingView(isNextPage: isNextPage)
        self.presenter?.presentUpcomingMovies(movies: viewModel)
    }
    
    private func manageError(with error: MovieTouchApiError) {
        self.presenter?.closeLoadingView(isNextPage: isNextPage)
        self.presenter?.presentError(message: error.localizedDescription, isSearching: isSearching)
    }
    
    private func startSearching() {
        isSearching = true
        cachePreviousData()
        currentPage = 0
        totalPages = 1
        moviesData = []
    }
    
    private func cachePreviousData() {
        self.cacheData = (page: currentPage, totalPages: totalPages, movies: moviesData)
    }
    
    private func treatUpcomingMoviesData(movies: [Movie]) -> [UpcomingMoviesViewModel] {
        
        return movies.map { UpcomingMoviesViewModel(genres: convertGenresToString(genresIds: $0.genreIDS),
                                                    poster: $0.posterPath ?? "",
                                                    backdrop: $0.backdropPath ?? "",
                                                    overview: $0.overview,                                                  movieName: $0.title,
                                                    releaseDate: $0.releaseDate.formatString())}
    }
    
    private func convertGenresToString(genresIds: [Int]) -> String{
        return genresIds.reduce(String(),
                      { (genresString, genreId) -> String in
                        var genresString = genresString
                        genresString.append(contentsOf: " "+(self.genres[genreId] ?? "")+" |" )
                        
                        return genresString})
    }
}
