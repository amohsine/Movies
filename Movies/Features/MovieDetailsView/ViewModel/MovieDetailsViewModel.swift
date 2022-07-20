//
//  MovieDetailsViewModel.swift
//  Movies
//
//  Created by Anas on 19/7/2022.
//

import Foundation

class MovieDetailsViewModel {
    var movie: ObservableObject<Movie?> = ObservableObject(nil)
    
    // MARK: - Load movie

    private let networkService: NetworkService
    
    init(networkService: NetworkService = .shared) {
        self.networkService = networkService
    }
    
    func loadMovieDetails() {
        networkService.getMovieDetails(id: movie.value!.id) { movie, success in
            self.movie.value = movie
        }
    }

}
