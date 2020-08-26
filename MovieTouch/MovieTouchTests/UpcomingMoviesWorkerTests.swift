//
//  UpcomingMoviesWorkerTests.swift
//  MovieTouchTests
//
//  Created by Thiago Santiago on 3/2/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import XCTest
@testable import MovieTouch

class UpcomingMoviesWorkerTests: XCTestCase {
    var worker: UpcomingMoviesWorker!
    var requester: MovieTouchApiRequestMock!
    
    override func setUp() {
        self.requester = MovieTouchApiRequestMock()
        self.worker = UpcomingMoviesWorker(requester: self.requester)
    }

    // MARK: UpcomingMoviesTests
    func testShouldGetTheListOfUpcomingMoviesWithSuccess() {
        self.requester.isFailure = false
        self.requester.jsonData = "upcoming_movies"
        
        self.worker.getUpcomingMovies(page: 1, success: { result in
            let movie = Movie(id: 166428, voteCount: 807, video: false, voteAverage: 7.9, title: "How to Train Your Dragon: The Hidden World", popularity: 201.622, posterPath: "/xvx4Yhf0DVH8G4LzNISpMfFBDy2.jpg", originalTitle: "How to Train Your Dragon: The Hidden World", genreIDS: [16,10751,12], backdropPath: "/h3KN24PrOheHVYs9ypuOIdFBEpX.jpg", adult: false, overview: "As Hiccup fulfills his dream of creating a peaceful dragon utopia, Toothless’ discovery of an untamed, elusive mate draws the Night Fury away. When danger mounts at home and Hiccup’s reign as village chief is tested, both dragon and rider must make impossible decisions to save their kind.", releaseDate: "2019-01-03")
            
            let upcomingMovies = UpcomingMovies(movies: [movie], page: 1, totalResults: 209, totalPages: 11)
            let firstMovie = result.movies.first
            
            XCTAssertNotNil(result)
            XCTAssertFalse(result.movies.isEmpty)
            XCTAssertEqual(movie, firstMovie)
            XCTAssertEqual(upcomingMovies.page, result.page)
            XCTAssertEqual(upcomingMovies.totalPages, result.totalPages)
            XCTAssertEqual(upcomingMovies.totalResults, result.totalResults)
        }) { _ in
            XCTFail("Could not return upcoming movies.")
        }
    }
    
    func testShouldGetTheListOfUpcomingMoviesWithBadUrlError() {
        self.requester.isFailure = true
        self.requester.failureType = .badUrl
        
        
        self.worker.getUpcomingMovies(page: 1, success: { _ in
            XCTFail("The test should to return an error.")
        }) { error in
            let errorMessage = "Bad URL request"
            
            XCTAssertNotNil(error)
            XCTAssertEqual(error, MovieTouchApiError.badUrl)
            XCTAssertEqual(errorMessage, error.localizedDescription)
        }
    }
    
    func testShouldGetTheListOfUpcomingMoviesWithDataError() {
        self.requester.isFailure = true
        self.requester.failureType = .dataError
        
        
        self.worker.getUpcomingMovies(page: 1, success: { _ in
            XCTFail("The test should to return an error.")
        }) { error in
            let errorMessage = "The received data is broken."
            
            XCTAssertNotNil(error)
            XCTAssertEqual(error, MovieTouchApiError.brokenData)
            XCTAssertEqual(errorMessage, error.localizedDescription)
        }
    }
    
    func testShouldGetTheListOfUpcomingMoviesWithResponseError() {
        self.requester.isFailure = true
        self.requester.failureType = .responseError
        
        self.worker.getUpcomingMovies(page: 1, success: { _ in
            XCTFail("The test should to return an error.")
        }) { error in
            let errorMessage = "Could not cast to HTTPURLResponse object."
            
            XCTAssertNotNil(error)
            XCTAssertEqual(error, MovieTouchApiError.unknown(errorMessage))
            XCTAssertEqual(errorMessage, error.localizedDescription)
        }
    }
    
    func testShouldGetTheListOfUpcomingMoviesWithUnknownError() {
        self.requester.isFailure = true
        self.requester.failureType = .unknownError
        
        self.worker.getUpcomingMovies(page: 1, success: { _ in
            XCTFail("The test should to return an error.")
        }) { error in
            let errorMessage = ""
            
            XCTAssertNotNil(error)
            XCTAssertEqual(error, MovieTouchApiError.unknown(""))
            XCTAssertEqual(errorMessage, error.localizedDescription)
        }
    }
    
    func testShouldGetTheListOfUpcomingMoviesWithParseError() {
        self.requester.isFailure = false
        self.requester.jsonData = "parse_error"
        
        self.worker.getUpcomingMovies(page: 1, success: { _ in
            XCTFail("The test should to return an error.")
        }) { error in
            let errorMessage = "Can't convert the data to the object entity."
            
            XCTAssertNotNil(error)
            XCTAssertEqual(error, MovieTouchApiError.couldNotParseObject)
            XCTAssertEqual(errorMessage, error.localizedDescription)
        }
    }
    
    // MARK: GetMovieGenres
    func testShouldGetTheListOfGenresWithSuccess() {
        self.requester.isFailure = false
        self.requester.jsonData = "genres"
        
        self.worker.getMovieGenres(success: { (result) in
            
            let genre = Genre(id: 28, name: "Action")
            let firstElement = result.genres.first
            
            XCTAssertNotNil(result)
            XCTAssertFalse(result.genres.isEmpty)
            XCTAssertEqual(genre, firstElement)
        }) { _ in
            XCTFail("Could not return genre movies.")
        }
    }
    
    func testShouldGetTheListOfGenresWithBadUrlError() {
        self.requester.isFailure = true
        self.requester.failureType = .badUrl
        
        self.worker.getMovieGenres(success: { _ in
            XCTFail("The test should to return an error.")
        }) { error in
            let errorMessage = "Bad URL request"
            
            XCTAssertNotNil(error)
            XCTAssertEqual(error, MovieTouchApiError.badUrl)
            XCTAssertEqual(errorMessage, error.localizedDescription)
        }
    }
    
    func testShouldGetTheListOfGenresWithDataError() {
        self.requester.isFailure = true
        self.requester.failureType = .dataError
        
        self.worker.getMovieGenres(success: { _ in
             XCTFail("The test should to return an error.")
        }) { error in
            let errorMessage = "The received data is broken."
            
            XCTAssertNotNil(error)
            XCTAssertEqual(error, MovieTouchApiError.brokenData)
            XCTAssertEqual(errorMessage, error.localizedDescription)
        }
    }
    
    func testShouldGetTheListOfGenresWithResponseError() {
        self.requester.isFailure = true
        self.requester.failureType = .responseError
        
        self.worker.getMovieGenres(success: { _ in
            XCTFail("The test should to return an error.")
        }) { error in
            let errorMessage = "Could not cast to HTTPURLResponse object."
            
            XCTAssertNotNil(error)
            XCTAssertEqual(error, MovieTouchApiError.unknown(errorMessage))
            XCTAssertEqual(errorMessage, error.localizedDescription)
        }
    }
    
    func testShouldGetTheListOfGenresWithUnknownError() {
        self.requester.isFailure = true
        self.requester.failureType = .unknownError
        
        self.worker.getMovieGenres(success: { _ in
            XCTFail("The test should to return an error.")
        }) { error in
            let errorMessage = ""
            
            XCTAssertNotNil(error)
            XCTAssertEqual(error, MovieTouchApiError.unknown(""))
            XCTAssertEqual(errorMessage, error.localizedDescription)
        }
    }
    
    func testShouldGetTheListOfGenresWithParseError() {
        self.requester.isFailure = false
        self.requester.jsonData = "parse_error"
        
        self.worker.getMovieGenres(success: { _ in
            XCTFail("The test should to return an error.")
        }) { error in
            let errorMessage = "Can't convert the data to the object entity."
            
            XCTAssertNotNil(error)
            XCTAssertEqual(error, MovieTouchApiError.couldNotParseObject)
            XCTAssertEqual(errorMessage, error.localizedDescription)
        }
    }
    
    //MARK: searchMovies
    func testShouldGetTheSearchedMoviesWithSuccess() {
        self.requester.isFailure = false
        self.requester.jsonData = "searched_movies"
        
        self.worker.searchMovies(text: "Harry Potter", page: 1, success: { result in
            
            let movie = Movie(id: 671, voteCount: 13032, video: false, voteAverage: 7.8, title: "Harry Potter and the Philosopher's Stone", popularity: 52.698, posterPath: "/dCtFvscYcXQKTNvyyaQr2g2UacJ.jpg", originalTitle: "Harry Potter and the Philosopher's Stone", genreIDS: [12,14,10751], backdropPath: "/hziiv14OpD73u9gAak4XDDfBKa2.jpg", adult: false, overview: "Harry Potter has lived under the stairs at his aunt and uncle's house his whole life. But on his 11th birthday, he learns he's a powerful wizard -- with a place waiting for him at the Hogwarts School of Witchcraft and Wizardry. As he learns to harness his newfound powers with the help of the school's kindly headmaster, Harry uncovers the truth about his parents' deaths -- and about the villain who's to blame.", releaseDate: "2001-11-16")
            
            let searchedMovies = UpcomingMovies(movies: [movie], page: 1, totalResults: 28, totalPages: 2)
            let firstMovie = result.movies.first
            
            XCTAssertNotNil(result)
            XCTAssertFalse(result.movies.isEmpty)
            XCTAssertEqual(movie, firstMovie)
            XCTAssertEqual(searchedMovies.page, result.page)
            XCTAssertEqual(searchedMovies.totalPages, result.totalPages)
            XCTAssertEqual(searchedMovies.totalResults, result.totalResults)
        }) { error in
            XCTFail("Could not return the searched movies.")
        }
    }
    
    func testShouldGetTheSearchedMoviesWithBadUrlError() {
        self.requester.isFailure = true
        self.requester.failureType = .badUrl
        
        self.worker.searchMovies(text: "Harry Potter", page: 1, success: { _ in
            XCTFail("The test should to return an error.")
        }) { error in
            let errorMessage = "Bad URL request"
            
            XCTAssertNotNil(error)
            XCTAssertEqual(error, MovieTouchApiError.badUrl)
            XCTAssertEqual(errorMessage, error.localizedDescription)
        }
    }
    
    func testShouldGetTheSearchedMoviesWithDataError() {
        self.requester.isFailure = true
        self.requester.failureType = .dataError
        
        self.worker.searchMovies(text: "Harry Potter", page: 1, success: { _ in
            XCTFail("The test should to return an error.")
        }) { error in
            let errorMessage = "The received data is broken."
            
            XCTAssertNotNil(error)
            XCTAssertEqual(error, MovieTouchApiError.brokenData)
            XCTAssertEqual(errorMessage, error.localizedDescription)
        }
    }
    
    func testShouldGetTheSearchedMoviesWithResponseError() {
        self.requester.isFailure = true
        self.requester.failureType = .responseError
        
        self.worker.searchMovies(text: "Harry Potter", page: 1, success: { _ in
            XCTFail("The test should to return an error.")
        }) { error in
            let errorMessage = "Could not cast to HTTPURLResponse object."
            
            XCTAssertNotNil(error)
            XCTAssertEqual(error, MovieTouchApiError.unknown(errorMessage))
            XCTAssertEqual(errorMessage, error.localizedDescription)
        }
    }
    
    func testShouldGetTheSearchedMoviesWithUnknownError() {
        self.requester.isFailure = true
        self.requester.failureType = .unknownError
        
        
        self.worker.searchMovies(text: "Harry Potter", page: 1, success: { _ in
            XCTFail("The test should to return an error.")
        }) { error in
            let errorMessage = ""
            
            XCTAssertNotNil(error)
            XCTAssertEqual(error, MovieTouchApiError.unknown(""))
            XCTAssertEqual(errorMessage, error.localizedDescription)
        }
    }
    
    func testShouldGetTheSearchedMoviesWithParseError() {
        self.requester.isFailure = false
        self.requester.jsonData = "parse_error"
        
        self.worker.searchMovies(text: "Harry Potter", page: 1, success: { _ in
            XCTFail("The test should to return an error.")
        }) { error in
            let errorMessage = "Can't convert the data to the object entity."
            
            XCTAssertNotNil(error)
            XCTAssertEqual(error, MovieTouchApiError.couldNotParseObject)
            XCTAssertEqual(errorMessage, error.localizedDescription)
        }
    }
}
