//
//  MovieDetailsViewController.swift
//  MovieTouch
//
//  Created by Thiago Santiago on 3/3/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import UIKit
import SDWebImage

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet private weak var moviePoster: UIImageView!
    @IBOutlet private weak var movieBackdrop: UIImageView!
    @IBOutlet private weak var headerView: UIView!
    @IBOutlet private weak var movieName: UILabel!
    @IBOutlet private weak var movieGenres: UILabel!
    @IBOutlet private weak var releaseDate: UILabel!
    @IBOutlet private weak var overview: UILabel!

    var movie: UpcomingMoviesViewModel?
    var gradientFrame = CGRect.zero
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configViews()
        setContent()
    }
    
    override func viewDidLayoutSubviews() {
        self.headerView.layer.sublayers?.forEach {
            if $0.isKind(of: CAGradientLayer.self) {
                $0.frame = gradientFrame
            }
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
            gradientFrame = CGRect(x: 0, y: 0, width: 896.0, height: self.headerView.bounds.height)
        } else {
            gradientFrame = CGRect(x: 0, y: 0, width: 414.0, height: self.headerView.bounds.height)
        }
    }
    
    private func configViews() {
        self.moviePoster.layer.cornerRadius = 8
        self.movieBackdrop.layer.cornerRadius = 8
        
        self.headerView.setGradient(startColor: Colors.lightBlue.cgColor, finalColor: Colors.darkBlue.cgColor)
        verifyDeviceOrientation()
    }
    
    private func verifyDeviceOrientation() {
        if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft ||
            UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
            gradientFrame = CGRect(x: 0, y: 0, width: 896.0, height: self.headerView.bounds.height)
        } else if UIDevice.current.orientation == UIDeviceOrientation.portrait ||
            UIDevice.current.orientation == UIDeviceOrientation.portraitUpsideDown {
            gradientFrame = CGRect(x: 0, y: 0, width: 414.0, height: self.headerView.bounds.height)
        }
    }
    
    private func setContent() {
        self.movieName.text = movie?.movieName
        self.movieGenres.text = movie?.genres
        self.releaseDate.text = movie?.releaseDate
        self.overview.text = movie?.overview
        
        self.moviePoster.sd_setImage(with: URL(string: "\(Constants.imageBaseUrl)\(String(describing: movie?.poster ?? ""))"), placeholderImage: UIImage(named: "poster_placeholder"))
        self.movieBackdrop.sd_setImage(with: URL(string: "\(Constants.imageBaseUrl)\(String(describing: movie?.backdrop ?? ""))"), placeholderImage: UIImage(named: "backdrop_placeholder"))
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        AppRouter.shared.popViewController()
    }
}
