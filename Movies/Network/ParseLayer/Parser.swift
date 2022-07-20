//
//  Parser.swift
//  Movies
//
//  Created by Anas on 19/7/2022.
//

import Foundation

class Parser<T> {
    
    static func parseJSON<T: Decodable>(data: Data) -> T? {
        var returnValue: T?
        do {
            let decoder = JSONDecoder()

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            decoder.dateDecodingStrategy = .formatted(dateFormatter)

            returnValue = try decoder.decode(T.self, from: data)
        } catch {
            print("Error took place: \(error.localizedDescription).")
        }
        
        return returnValue
    }
}
