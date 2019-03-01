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
    func displayError(_ message: String)
    func displayUpcomingMovies(_ list: [UpcomingMoviesViewModel])
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
    var interactor: UpcomingMoviesInteractor?
    private var tableViewData: [UpcomingMoviesViewModel] = []
    
    //MARK: Lifecycle
    init(interactor: UpcomingMoviesInteractor) {
        super.init(nibName: "UpcomingMoviesViewController", bundle: Bundle.main)
        self.interactor = interactor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        self.interactor?.getUpcomingMovies()
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
}

//MARK: UITableViewDelegate / UITableViewDataSource
extension UpcomingMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UpcomingMoviesCell", for: indexPath) as? UpcomingMoviesCell else {
            return UITableViewCell()
        }
        
        cell.setContent(movie: tableViewData[indexPath.row])
        return cell
    }
}

extension UpcomingMoviesViewController: UpcomingMoviesProtocol {
    func hideLoadingView() {
        self.hideLoader()
    }
    
    func displayLoadingView() {
        self.showLoader()
    }
    
    func displayError(_ message: String) {
        // impelement the error feedback
    }
    
    func displayUpcomingMovies(_ list: [UpcomingMoviesViewModel]) {
        self.tableViewData = list
        self.tableView.reloadData()
    }
}
