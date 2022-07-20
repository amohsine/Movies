//
//  MoviesResponse.swift
//  Movies
//
//  Created by Anas on 19/7/2022.
//

import Foundation

struct MoviesResponse: Decodable {
    let results: [Movie]
    let page: Int
    let totalPages: Int
    let totalResults: Int
    
    private enum CodingKeys: String, CodingKey {
        case results
        case page
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
