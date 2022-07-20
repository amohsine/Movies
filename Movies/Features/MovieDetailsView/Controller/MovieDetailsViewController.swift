//
//  MovieDetailsViewController.swift
//  Movies
//
//  Created by Anas on 19/7/2022.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieDateLabel: UILabel!
    @IBOutlet weak var movieOverviewTextView: UITextView!
    
    var viewModel = MovieDetailsViewModel()
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupBinders()
        viewModel.loadMovieDetails()
    }
    
    // MARK: - Binding

    private func setupBinders() {
        viewModel.movie.bind { movie in
            DispatchQueue.main.async {
                self.movieImageView.load(urlString: movie?.imagePath ?? "")
                self.movieTitleLabel.text = movie?.title
                self.movieDateLabel.text = movie?.formattedReleaseDate
                self.movieOverviewTextView.text = movie?.overview
            }
        }
    }
}
