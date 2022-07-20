//
//  MoviesViewModel.swift
//  Movies
//
//  Created by Anas on 19/7/2022.
//

import Foundation

class MoviesViewModel {
    var movies: ObservableObject<[Movie]?> = ObservableObject(nil)
    var page: Int = 0

    // MARK: - Load movies

    private let networkService: NetworkService
    
    init(networkService: NetworkService = .shared) {
        self.networkService = networkService
    }
    
    func loadTrendingMovies() {
        self.networkService.getMovies(page: page + 1) { movies, page, success in
            if success {
                self.page = page!
                if self.movies.value == nil {
                    self.movies.value = movies
                } else {
                    self.movies.value?.append(contentsOf: movies!)
                }
            }
        }
    }

    // MARK: - Datasource

    func countOfTrendingMovies() -> Int {
        movies.value?.count ?? 0
    }
    
    func trendingMovie(at index: IndexPath) -> Movie? {
        guard let movies = movies.value, movies.indices.contains(index.row) else {
            return nil
        }
        return movies[index.row]
    }
    
}
