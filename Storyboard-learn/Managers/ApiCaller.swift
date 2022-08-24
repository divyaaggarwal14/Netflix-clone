//
//  ApiCaller.swift
//  Storyboard-learn
//
//  Created by Divya Aggarwal on 23/08/22.
//

import Foundation

struct Constants{
    static let API_KEY = "623245eccf79e260944f11c7ddcf7ab3"
    static let baseURL = "https://api.themoviedb.org"
}

enum APIError:Error{
    case failedToGetData
}

class ApiCaller{
    static let shared = ApiCaller()
    
    func getTrendingMovies(completion: @escaping (Result<[Title],Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url:url)){data, _, error in
            guard let data = data else {
                return
            }
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self,from:data)
                completion(.success(results.results))
            }catch{
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    
    func getTrendingTVs(completion: @escaping (Result<[Title],Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url:url)){data, _, error in
            guard let data = data else {
                return
            }
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self,from:data)
                completion(.success(results.results))
            }catch{
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    
    func getUpcomingMovies(completion: @escaping (Result<[Title],Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url:url)){data, _, error in
            guard let data = data else {
                return
            }
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self,from:data)
                completion(.success(results.results))
            }catch{
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    
    func getPopularMovies(completion: @escaping (Result<[Title],Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url:url)){data, _, error in
            guard let data = data else {
                return
            }
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self,from:data)
                completion(.success(results.results))
            }catch{
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    
    func getTopRatedMovies(completion: @escaping (Result<[Title],Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/top_rated?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url:url)){data, _, error in
            guard let data = data else {
                return
            }
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self,from:data)
                completion(.success(results.results))
            }catch{
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }

    
    func getDiscoverMovies(completion: @escaping (Result<[Title],Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/discover/movie?api_key=\(Constants.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url:url)){data, _, error in
            guard let data = data else {
                return
            }
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self,from:data)
                completion(.success(results.results))
            }catch{
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }

    
    func search(query:String, completion: @escaping (Result<[Title],Error>) -> Void){
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constants.baseURL)/3/search/movie?api_key=\(Constants.API_KEY)&query=\(query)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url:url)){data, _, error in
            guard let data = data else {
                return
            }
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self,from:data)
                completion(.success(results.results))
            }catch{
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
}
