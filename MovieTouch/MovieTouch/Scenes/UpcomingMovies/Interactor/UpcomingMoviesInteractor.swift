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
    private var presenter: UpcomingMoviesPresenterProtocol?
    private var worker: UpcomingMoviesWorker?
    
    private var upcomingMoviesData: [Movie] = []
    private var genres:[Int:String] = [:]
    private var isWaitingResponse: Bool = false
    
    private var currentPage: Int = 0
    private var totalPages: Int = 0
    
    private var filteredMoviesData: [Movie] = []
    private var currentFilteredPage: Int = 0
    private var totalFilteredPages: Int = 0
    private var isSearching: Bool = false
    private var textToSearch: String = ""
    
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
            self.presenter?.closeLoadingView()
            self.presenter?.presentError(message: error.localizedDescription)
        })
    }
    
    func getUpcomingMovies() {
        currentPage = 1
        presenter?.presentLoadingView()
        if verifyGenres() {
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
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                self.getUpcomingMovies()
            })
        }
    }
    
    func getNextUpcomingMovie() {
        if isSearching {
            nextFilteredPage()
        } else {
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
                        self.presenter?.closeFooterLoading()
                        self.presenter?.presentError(message: error.localizedDescription)
                    })
                }
            }
        }
        
    }
    
    func searchMovies(text: String) {
        isSearching = true
        textToSearch = text
        currentFilteredPage += 1
        
        presenter?.presentLoadingView()
        worker?.searchMovies(text: text, page: currentFilteredPage, success: { result in
            self.totalFilteredPages = result.totalPages
            self.filteredMoviesData.append(contentsOf: result.movies)
            let viewModel = self.treatUpcomingMoviesData(movies: result.movies)
            self.presenter?.closeLoadingView()
            self.presenter?.presentUpcomingMovies(movies: viewModel)
        }, failure: { error in
            self.presenter?.closeLoadingView()
            self.presenter?.presentError(message: error.localizedDescription)
        })
    }
    
    func nextFilteredPage() {
        if !isWaitingResponse {
            currentFilteredPage += 1
            if currentFilteredPage <= totalFilteredPages {
                isWaitingResponse = true
                presenter?.presentFooterLoading()
                worker?.searchMovies(text: textToSearch, page: currentFilteredPage, success: { result in
                    self.isWaitingResponse = false
                    self.presenter?.closeFooterLoading()
                    self.filteredMoviesData.append(contentsOf: result.movies)
                    let viewModel = self.treatUpcomingMoviesData(movies: self.filteredMoviesData)
                    self.presenter?.presentUpcomingMovies(movies: viewModel)
                }, failure: { error in
                    self.isWaitingResponse = false
                    self.presenter?.closeFooterLoading()
                    self.presenter?.presentError(message: error.localizedDescription)
                })
            }
        }
    }
    
    func cancelSearch() {
        self.isSearching = false
        let viewModel = self.treatUpcomingMoviesData(movies: self.upcomingMoviesData)
        self.presenter?.presentUpcomingMovies(movies: viewModel)
    }
    
    private func verifyGenres() ->  Bool {
        if self.genres.isEmpty {
            self.getGenres()
            return false
        } else {
            return true
        }
    }
    
    private func treatUpcomingMoviesData(movies: [Movie]) -> [UpcomingMoviesViewModel] {
        
        return movies.map { UpcomingMoviesViewModel(genres: convertGenresToString(genresIds: $0.genreIDS),
                                                    poster: $0.posterPath ?? "",
                                                    backdrop: $0.backdropPath ?? "",                                                    movieName: $0.title,
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
