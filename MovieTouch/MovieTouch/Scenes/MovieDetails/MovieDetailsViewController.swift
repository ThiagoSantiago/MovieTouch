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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configViews()
        setContent()
    }
    
    private func configViews() {
        self.moviePoster.layer.cornerRadius = 8
        self.movieBackdrop.layer.cornerRadius = 8
        
        self.headerView.setGradient(startColor: Colors.lightBlue.cgColor, finalColor: Colors.darkBlue.cgColor)
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
