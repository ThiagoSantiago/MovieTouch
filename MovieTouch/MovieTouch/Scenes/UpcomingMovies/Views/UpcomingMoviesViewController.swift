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
    func hideFooterLoading()
    func displayLoadingView()
    func displayFooterLoading()
    func displayError(_ message: String, hideButton: Bool)
    func displayUpcomingMovies(_ list: [UpcomingMoviesViewModel])
}

class UpcomingMoviesViewController: BaseViewController {
    
    //MARK: Outlets
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var auxView: UIView!
    @IBOutlet private weak var auxImageView: UIImageView!
    @IBOutlet private weak var headerView: UIView!
    @IBOutlet private weak var auxViewMessage: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var tryAgainButton: UIButton!

    //MARK: Properties
    private var footer: FooterLoaderView?
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
    
    override func viewDidLayoutSubviews() {
        self.headerView.layer.sublayers?.forEach {
            if $0.isKind(of: CAGradientLayer.self) {
                $0.frame = self.headerView.layer.bounds
            }
        }
    }
    
    private func setup() {
        self.searchBar.delegate = self
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
        self.footer = FooterLoaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        self.tableView.tableFooterView = footer
    }
    
    //MARK: Actions
    @IBAction func tryAgainButtonPressed(_ sender: Any) {
        self.interactor?.getUpcomingMovies()
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.tableViewData.count - 1 {
            self.interactor?.getNextUpcomingMovie()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        AppRouter.shared.routeToMovieDetails(viewModel: self.tableViewData[indexPath.row])
    }
}

//MARK: UISearchBarDelegate
extension UpcomingMoviesViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        interactor?.cancelSearch()
        self.tableView.reloadData()
        self.searchBar.text = ""
        self.searchBar.resignFirstResponder()
        let indexPath = NSIndexPath(item: 0, section: 0)
        self.tableView.scrollToRow(at: indexPath as IndexPath, at: UITableView.ScrollPosition.middle, animated: true)
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
        guard let textToSearch = searchBar.text else { return }
        let trimmedString = textToSearch.trimmingCharacters(in: .whitespacesAndNewlines)
        if !(trimmedString == "") {
            interactor?.searchMovies(text: textToSearch)
        }
    }
}

//MARK: UpcomingMoviesProtocol
extension UpcomingMoviesViewController: UpcomingMoviesProtocol {
    
    func hideLoadingView() {
        self.hideLoader()
    }
    
    func hideFooterLoading() {
        footer?.hide()
    }
    
    func displayLoadingView() {
        self.showLoader()
    }
    
    func displayFooterLoading() {
        footer?.show()
    }
    
    func displayError(_ message: String, hideButton: Bool) {
        self.auxView.isHidden = false
        self.tableView.isHidden = true
        
        self.auxImageView.image = UIImage(named: "error_icon")
        self.auxViewMessage.text = message
        
        self.tryAgainButton.isHidden = hideButton
    }
    
    func displayUpcomingMovies(_ list: [UpcomingMoviesViewModel]) {
        self.auxView.isHidden = true
        self.tableView.isHidden = false
        
        self.tableViewData = list
        self.tableView.reloadData()
    }
}
