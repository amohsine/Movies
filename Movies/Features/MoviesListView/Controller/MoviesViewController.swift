//
//  MoviesViewController.swift
//  Movies
//
//  Created by Anas on 19/7/2022.
//

import UIKit

class MoviesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var spinner: UIActivityIndicatorView!

    let viewModel = MoviesViewModel()

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBinders()
        setupUI()
        viewModel.loadTrendingMovies()
    }
    
    // MARK: - Binding

    private func setupBinders() {
        viewModel.movies.bind { movies in
            guard movies != nil else { return }
            DispatchQueue.main.async {
                self.stopSpinner()
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToMovieDetails" {
            let movieDetailsVC = segue.destination as! MovieDetailsViewController
            movieDetailsVC.viewModel.movie.value = sender as? Movie
        }
    }
    
    // MARK: - UI

    func setupUI() {
        addSpinner()
        startSpinner()
    }
    
    func addSpinner() {
        if #available(iOS 13.0, *) {
            spinner = UIActivityIndicatorView(style: .large)
        } else {
            spinner = UIActivityIndicatorView(style: .whiteLarge)
        }

        if let spinner = spinner {
            view.addSubview(spinner)
            spinner.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height - 40)
        }
    }

    func startSpinner() {
        if let spinner = spinner {
            spinner.startAnimating()
        }
    }

    func stopSpinner() {
        if let spinner = spinner {
            spinner.stopAnimating()
        }
    }
}

extension MoviesViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - TableView Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.countOfTrendingMovies()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieItemViewCell.cellId, for: indexPath) as! MovieItemViewCell
        if let movie = viewModel.trendingMovie(at: indexPath) {
            cell.configureCell(movie: movie)
        }
        
        let datasourceCount = viewModel.countOfTrendingMovies()
        if indexPath.row == datasourceCount - 1 && datasourceCount > 0 {
            // when reaching the last cell, load the next movies batch
            viewModel.loadTrendingMovies()
        }
        return cell
    }
    
    // MARK: - TableView Delegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let movie = viewModel.trendingMovie(at: indexPath) {
            performSegue(withIdentifier: "goToMovieDetails", sender: movie)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

