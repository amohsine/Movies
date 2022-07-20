//
//  Constants.swift
//  Movies
//
//  Created by Anas on 19/7/2022.
//

import Foundation

struct Constants {
    static let APIKey           = "c9856d0cb57c3f14bf75bdc6c063b8f3"
    static let BaseURL          = "https://api.themoviedb.org/3/"
    static let MovieDiscoverURL = BaseURL + "discover/movie" + "?api_key=" + APIKey + "&page={page}"
    static let MovieDetailsURL  = BaseURL + "movie/{movie_id}" + "?api_key=" + APIKey
    static let ImageBaseURL     = "https://image.tmdb.org/t/p/w500/"
}
