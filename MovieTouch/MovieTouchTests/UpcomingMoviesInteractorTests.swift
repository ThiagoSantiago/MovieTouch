//
//  UpcomingMoviesInteractorTests.swift
//  MovieTouchTests
//
//  Created by Thiago Santiago on 3/2/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import XCTest
@testable import MovieTouch

class UpcomingMoviesPresernterTests: XCTestCase {
    var worker: UpcomingMoviesWorker!
    var requester: MovieTouchApiRequestMock!
    var interactor: UpcomingMoviesInteractor!
    var presenter: UpcomingMoviesPresenterMock!
    
    override func setUp() {
        super.setUp()
        
        self.requester = MovieTouchApiRequestMock()
        self.presenter = UpcomingMoviesPresenterMock()
        self.worker = UpcomingMoviesWorker(requester: self.requester)
        self.interactor = UpcomingMoviesInteractor(presenter: self.presenter, worker: self.worker)
    }
    
    func testShouldGetListOfGenresWhenWorkerRetrunsError() {
        requester.isFailure = true
        interactor.getGenres()
        
        XCTAssertFalse(presenter.moviesListPresented)
        XCTAssertTrue(presenter.closeLoadingPresented)
        XCTAssertTrue(presenter.errorWasPresented)
    }
    
    func testShouldPresentListOfMoviesWhenWorkerRetrunsSuccess() {
        requester.isFailure = false
        self.requester.jsonData = "genres"
        interactor.getGenres()
        self.requester.jsonData = "upcoming_movies"
        interactor.getUpcomingMovies()
        
        let viewModel = UpcomingMoviesViewModel(genres: " Animation | Family | Adventure |", poster: "/xvx4Yhf0DVH8G4LzNISpMfFBDy2.jpg", backdrop: "/h3KN24PrOheHVYs9ypuOIdFBEpX.jpg", overview: "As Hiccup fulfills his dream of creating a peaceful dragon utopia, Toothless’ discovery of an untamed, elusive mate draws the Night Fury away. When danger mounts at home and Hiccup’s reign as village chief is tested, both dragon and rider must make impossible decisions to save their kind.", movieName: "How to Train Your Dragon: The Hidden World", releaseDate: "03/01/2019")
        
        XCTAssertTrue(presenter.loadingPresented)
        XCTAssertTrue(presenter.moviesListPresented)
        XCTAssertTrue(presenter.closeLoadingPresented)
        XCTAssertFalse(presenter.errorWasPresented)
        XCTAssertEqual(viewModel, presenter.viewModel?.first!)
    }
    
    func testShouldPresentListOfMoviesWhenWorkerRetrunsError() {
        requester.isFailure = false
        self.requester.jsonData = "genres"
        interactor.getGenres()
        
        requester.isFailure = true
        interactor.getUpcomingMovies()
        
        
        XCTAssertTrue(presenter.loadingPresented)
        XCTAssertFalse(presenter.moviesListPresented)
        XCTAssertTrue(presenter.closeLoadingPresented)
        XCTAssertTrue(presenter.errorWasPresented)
    }
    
    func testShouldPresentNextPageOfListOfMoviesWhenWorkerRetrunsSuccess() {
        requester.isFailure = false
        self.requester.jsonData = "genres"
        interactor.getGenres()
        
        self.requester.jsonData = "upcoming_movies"
        interactor.getUpcomingMovies()
        
        self.requester.jsonData = "upcoming_movies"
        interactor.getNextUpcomingMovie()
        
         let viewModel = UpcomingMoviesViewModel(genres: " Animation | Family | Adventure |", poster: "/xvx4Yhf0DVH8G4LzNISpMfFBDy2.jpg", backdrop: "/h3KN24PrOheHVYs9ypuOIdFBEpX.jpg", overview: "As Hiccup fulfills his dream of creating a peaceful dragon utopia, Toothless’ discovery of an untamed, elusive mate draws the Night Fury away. When danger mounts at home and Hiccup’s reign as village chief is tested, both dragon and rider must make impossible decisions to save their kind.", movieName: "How to Train Your Dragon: The Hidden World", releaseDate: "03/01/2019")
        
        XCTAssertTrue(presenter.loadingPresented)
        XCTAssertTrue(presenter.moviesListPresented)
        XCTAssertTrue(presenter.closeLoadingPresented)
        XCTAssertFalse(presenter.errorWasPresented)
        XCTAssertEqual(viewModel, presenter.viewModel?.first!)
    }
    
    
    func testShouldPresentSearchedMoviesWhenWorkerRetrunsSuccess() {
        requester.isFailure = false
        self.requester.jsonData = "genres"
        interactor.getGenres()
        
        self.requester.jsonData = "upcoming_movies"
        interactor.getUpcomingMovies()
        
        self.requester.jsonData = "searched_movies"
        interactor.searchMovies(text: "Harry Potter")
        
        let viewModel = UpcomingMoviesViewModel(genres: " Adventure | Fantasy | Family |", poster: "/dCtFvscYcXQKTNvyyaQr2g2UacJ.jpg", backdrop: "/hziiv14OpD73u9gAak4XDDfBKa2.jpg", overview: "Harry Potter has lived under the stairs at his aunt and uncle's house his whole life. But on his 11th birthday, he learns he's a powerful wizard -- with a place waiting for him at the Hogwarts School of Witchcraft and Wizardry. As he learns to harness his newfound powers with the help of the school's kindly headmaster, Harry uncovers the truth about his parents' deaths -- and about the villain who's to blame.", movieName: "Harry Potter and the Philosopher\'s Stone", releaseDate: "16/11/2001")
        
        XCTAssertTrue(presenter.loadingPresented)
        XCTAssertTrue(presenter.moviesListPresented)
        XCTAssertTrue(presenter.closeLoadingPresented)
        XCTAssertFalse(presenter.errorWasPresented)
        XCTAssertEqual(viewModel, presenter.viewModel?.first!)
    }
    
    func testShouldPresentNextSearchedMoviesWhenWorkerRetrunsSuccess() {
        requester.isFailure = false
        self.requester.jsonData = "genres"
        interactor.getGenres()
        
        self.requester.jsonData = "upcoming_movies"
        interactor.getUpcomingMovies()
        
        self.requester.jsonData = "searched_movies"
        interactor.searchMovies(text: "Harry Potter")
        
        self.requester.jsonData = "searched_movies"
        interactor.nextFilteredPage()
        
        let viewModel = UpcomingMoviesViewModel(genres: " Adventure | Fantasy | Family |", poster: "/dCtFvscYcXQKTNvyyaQr2g2UacJ.jpg", backdrop: "/hziiv14OpD73u9gAak4XDDfBKa2.jpg", overview: "Harry Potter has lived under the stairs at his aunt and uncle's house his whole life. But on his 11th birthday, he learns he's a powerful wizard -- with a place waiting for him at the Hogwarts School of Witchcraft and Wizardry. As he learns to harness his newfound powers with the help of the school's kindly headmaster, Harry uncovers the truth about his parents' deaths -- and about the villain who's to blame.", movieName: "Harry Potter and the Philosopher\'s Stone", releaseDate: "16/11/2001")
        
        XCTAssertTrue(presenter.loadingPresented)
        XCTAssertTrue(presenter.moviesListPresented)
        XCTAssertTrue(presenter.closeLoadingPresented)
        XCTAssertFalse(presenter.errorWasPresented)
        XCTAssertEqual(viewModel, presenter.viewModel?.first!)
    }
    
    func testShouldPresentTheCachedMoviesWhenSearchIsCanceled() {
        requester.isFailure = false
        self.requester.jsonData = "genres"
        interactor.getGenres()
        
        self.requester.jsonData = "upcoming_movies"
        interactor.getUpcomingMovies()
        
        self.requester.jsonData = "searched_movies"
        interactor.searchMovies(text: "Harry Potter")
        interactor.cancelSearch()
        
        let viewModel = UpcomingMoviesViewModel(genres: " Animation | Family | Adventure |", poster: "/xvx4Yhf0DVH8G4LzNISpMfFBDy2.jpg", backdrop: "/h3KN24PrOheHVYs9ypuOIdFBEpX.jpg", overview: "As Hiccup fulfills his dream of creating a peaceful dragon utopia, Toothless’ discovery of an untamed, elusive mate draws the Night Fury away. When danger mounts at home and Hiccup’s reign as village chief is tested, both dragon and rider must make impossible decisions to save their kind.", movieName: "How to Train Your Dragon: The Hidden World", releaseDate: "03/01/2019")
        
        XCTAssertTrue(presenter.loadingPresented)
        XCTAssertTrue(presenter.moviesListPresented)
        XCTAssertTrue(presenter.closeLoadingPresented)
        XCTAssertFalse(presenter.errorWasPresented)
        XCTAssertEqual(viewModel, presenter.viewModel?.first!)
    }
}
