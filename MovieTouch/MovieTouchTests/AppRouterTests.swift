//
//  AppRouterTests.swift
//  MovieTouchTests
//
//  Created by Thiago Santiago on 3/3/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import XCTest
@testable import MovieTouch

class AppRoutertests: XCTestCase {
    var router: AppRouter!
    var navigationController: UINavigationController!
    
    override func setUp() {
        navigationController = UINavigationController()
        router = AppRouter.shared
        router.navigation = navigationController
    }
    
    func testWhenCallRouteToUpcomingMoviesThenNavigationPushUpcomingMoviesViewController() {
        router.routeToUpcomingMovies()
        
        XCTAssertEqual(router.navigation, navigationController)
        XCTAssertTrue(
            router.navigation.viewControllers.first!.isKind(of: UpcomingMoviesViewController.self)
        )
    }
    
    func testWhenCallRouteToMovieDetailsThenNavigationPushMovieDetailsViewController() {
        
        let viewModel = UpcomingMoviesViewModel(genres: " Animation | Family | Adventure |", poster: "/xvx4Yhf0DVH8G4LzNISpMfFBDy2.jpg", backdrop: "/h3KN24PrOheHVYs9ypuOIdFBEpX.jpg", overview: "As Hiccup fulfills his dream of creating a peaceful dragon utopia, Toothless’ discovery of an untamed, elusive mate draws the Night Fury away. When danger mounts at home and Hiccup’s reign as village chief is tested, both dragon and rider must make impossible decisions to save their kind.", movieName: "How to Train Your Dragon: The Hidden World", releaseDate: "03/01/2019")
        
        router.routeToMovieDetails(viewModel: viewModel)
        
        XCTAssertEqual(router.navigation, navigationController)
        XCTAssertTrue(
            router.navigation.viewControllers.first!.isKind(of: MovieDetailsViewController.self)
        )
    }
    
    func testWhenCallPopViewControllerThenNavigationPopTheTopViewController() {
        router.routeToUpcomingMovies()
        
        let viewModel = UpcomingMoviesViewModel(genres: " Animation | Family | Adventure |", poster: "/xvx4Yhf0DVH8G4LzNISpMfFBDy2.jpg", backdrop: "/h3KN24PrOheHVYs9ypuOIdFBEpX.jpg", overview: "As Hiccup fulfills his dream of creating a peaceful dragon utopia, Toothless’ discovery of an untamed, elusive mate draws the Night Fury away. When danger mounts at home and Hiccup’s reign as village chief is tested, both dragon and rider must make impossible decisions to save their kind.", movieName: "How to Train Your Dragon: The Hidden World", releaseDate: "03/01/2019")
        
        router.routeToMovieDetails(viewModel: viewModel)
        router.popViewController()
        
        XCTAssertEqual(router.navigation, navigationController)
        XCTAssertTrue(
            router.navigation.viewControllers.first!.isKind(of: UpcomingMoviesViewController.self)
        )
    }
}
