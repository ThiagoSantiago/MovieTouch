//
//  UpcomingMoviesCell.swift
//  MovieTouch
//
//  Created by Thiago Santiago on 2/28/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import UIKit
import SDWebImage

class UpcomingMoviesCell: UITableViewCell {
    
    @IBOutlet private weak var movieName: UILabel!
    @IBOutlet private weak var movieGenre: UILabel!
    @IBOutlet private weak var cellContent: UIView!
    @IBOutlet private weak var movieImage: UIImageView!
    @IBOutlet private weak var movieReleaseDate: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        configViews()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        super.setSelected(false, animated: true)
    }
    
    private func configViews() {
        self.cellContent.layer.cornerRadius = 8
    }

    func setContent(movie: UpcomingMoviesViewModel) {
        self.movieName.text = movie.movieName
        
        let genreFormatted = NSMutableAttributedString()
        genreFormatted.bold("Gênero:").normal(movie.genres)
        self.movieGenre.attributedText = genreFormatted
        
        let releaseDateFormatted = NSMutableAttributedString()
        releaseDateFormatted.bold("Lançamento: ").normal(movie.releaseDate)
        self.movieReleaseDate.attributedText = releaseDateFormatted
        
        self.movieImage.sd_setImage(with: URL(string: "\(Constants.imageBaseUrl)\(movie.poster)"), placeholderImage: UIImage(named: "poster_placeholder"))
    }
}
