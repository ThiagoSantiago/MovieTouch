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
    
    func testWhenCallRouteToHomeThenNavigationPushReviewsViewController() {
        router.routeToUpcomingMovies()
        
        XCTAssertEqual(router.navigation, navigationController)
        XCTAssertTrue(
            router.navigation.viewControllers.first!.isKind(of: UpcomingMoviesViewController.self)
        )
    }
}
