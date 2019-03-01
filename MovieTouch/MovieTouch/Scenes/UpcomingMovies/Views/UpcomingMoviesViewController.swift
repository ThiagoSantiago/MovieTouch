//
//  UpcomingMoviesViewController.swift
//  MovieTouch
//
//  Created by Thiago Santiago on 2/28/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import UIKit

protocol UpcomingMoviesProtocol: class {
    func hideLoadingView()
    func displayLoadingView()
    func displayError(message: String)
    func displayUpcomingMovies(list: [String])
}

class UpcomingMoviesViewController: BaseViewController {
    
    //MARK: Outlets
    @IBOutlet private weak var auxView: UIView!
    @IBOutlet private weak var auxImageView: UIImageView!
    @IBOutlet private weak var headerView: UIView!
    @IBOutlet private weak var auxViewMessage: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var tryAgainButton: UIButton!

    //MARK: Properties
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.viewsConfiguration()
        self.registerTableViewCells()
    }
    
    private func registerTableViewCells() {
        self.tableView.register(UINib(nibName: "UpcomingMoviesCell", bundle: nil), forCellReuseIdentifier: "UpcomingMoviesCell")
    }
    
    private func viewsConfiguration() {
        self.tryAgainButton.layer.cornerRadius = 25
        self.headerView.setGradient(startColor: Colors.lightBlue.cgColor, finalColor: Colors.darkBlue.cgColor)
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        
    }
}

//MARK: UITableViewDelegate / UITableViewDataSource
extension UpcomingMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UpcomingMoviesCell", for: indexPath) as? UpcomingMoviesCell else {
            return UITableViewCell()
        }
        
        return cell
    }
}
