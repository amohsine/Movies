//
//  Movie.swift
//  Movies
//
//  Created by Anas on 19/7/2022.
//

import Foundation

struct Movie: Decodable {
    let id: Int
    let title: String?
    let overview: String?
    let releaseDate: Date?
    let backdropPath: String?
    var imagePath: String {
        guard let backdropPath = backdropPath else { return "" }
        return Constants.ImageBaseURL + backdropPath
    }
    var formattedReleaseDate: String {
        guard let releaseDate = releaseDate else { return "--" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: releaseDate)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        overview = try container.decode(String.self, forKey: .overview)

        do {
            backdropPath = try container.decode(String.self, forKey: .backdropPath)
        } catch {
            backdropPath = ""
        }

        let dateString = try container.decode(String.self, forKey: .releaseDate)
        if !dateString.isEmpty {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            if let date = dateFormatter.date(from: dateString) {
                releaseDate = date
            } else {
                throw DecodingError.dataCorruptedError(forKey: .releaseDate,
                                                       in: container,
                                                       debugDescription: "Date string does not match format expected by formatter.")
            }
        } else {
            releaseDate = nil
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
    }
}

