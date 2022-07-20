//
//  MovieCell.swift
//  Movies
//
//  Created by Anas on 19/7/2022.
//

import UIKit

class MovieItemViewCell: UITableViewCell {
    static let cellId = "movieItemViewCell"
    var currentImagePath: String?
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
        
    func configureCell(movie: Movie) {
        currentImagePath = movie.imagePath
        self.titleLabel.text = movie.title
        self.dateLabel.text = movie.formattedReleaseDate
        
        // reset existing image content
        self.movieImageView.image = UIImage(named: "loading")

        // launch the request to load the new image
        self.movieImageView.load(urlString: movie.imagePath) { image, loadedtImagePath in
            
            // check if the loaded image corresponds to the expected one
            // this is to handle bad connectivity where cell may contain an old image
            if let currentImagePath = self.currentImagePath,
                currentImagePath == loadedtImagePath {
                self.movieImageView.image = image
            }
        }
    }
}
