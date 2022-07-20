//
//  NetworkService.swift
//  Movies
//
//  Created by Anas on 19/7/2022.
//

import Foundation

protocol NetworkServiceProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: NetworkServiceProtocol {
    
}

class NetworkService {
    static let shared = NetworkService()
    let networkSession: NetworkServiceProtocol
    
    init(networkSession: NetworkServiceProtocol = URLSession.shared) {
        self.networkSession = networkSession
    }

    private func getURLRequest(for path: String) -> URLRequest {
        let url = URL(string: path)
        guard let requestUrl = url else { fatalError() }
        return URLRequest(url: requestUrl)
    }
    
    func getMovies(page: Int, completion: @escaping (_ movies: [Movie]?,
                                                     _ page: Int?,
                                                     _ success: Bool) -> ()) {
        let path = Constants.MovieDiscoverURL.replacingOccurrences(of: "{page}", with: String(page))
        let request = getURLRequest(for: path)
        
        networkSession.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("Error took place \(error)")
                completion(nil, nil, false)
                return
            }
            
            guard let data = data else { return }
            let apiResponse: MoviesResponse? = Parser<Movie?>.parseJSON(data: data)
            guard let apiResponse = apiResponse else {
                completion(nil, nil, false)
                return
            }
            completion(apiResponse.results, apiResponse.page, true)
            
        }.resume()
    }
    
    func getMovieDetails(id: Int, completion: @escaping (Movie?, Bool) -> ()) {
        let path = Constants.MovieDetailsURL.replacingOccurrences(of: "{movie_id}", with: String(id))
        let request = getURLRequest(for: path)
        
        networkSession.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("Error took place \(error)")
                completion(nil, false)
                return
            }
            
            guard let data = data else { return }
            let apiResponse: Movie? = Parser<Movie?>.parseJSON(data: data)
            guard let apiResponse = apiResponse else { return }
            completion(apiResponse, true)
            
        }.resume()
    }
}
