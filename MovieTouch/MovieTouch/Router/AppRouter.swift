//
//  AppRouter.swift
//  MovieTouch
//
//  Created by Thiago Santiago on 2/28/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import UIKit

class AppRouter {
    
    var navigation: UINavigationController = UINavigationController()
    
    func routeToHome() {
        let presenter = UpcomingMoviesPresenter()
        let interactor = UpcomingMoviesInteractor(presenter: presenter)
        self.navigation.navigationBar.isHidden = true
        let viewController = UpcomingMoviesViewController(interactor: interactor)
        
        presenter.viewController = viewController
        self.navigation.pushViewController(viewController, animated: false)
    }
}
