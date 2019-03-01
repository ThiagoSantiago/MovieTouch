//
//  UpcomingMoviesCell.swift
//  MovieTouch
//
//  Created by Thiago Santiago on 2/28/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import UIKit

class UpcomingMoviesCell: UITableViewCell {
    
    @IBOutlet private weak var movieName: UILabel!
    @IBOutlet private weak var movieGenre: UILabel!
    @IBOutlet private weak var cellContent: UIView!
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

    func setContent() {
        // Set the values to be presented
    }
}
