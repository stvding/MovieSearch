//
//  MovieSearch.swift
//  MovieSearch
//
//  Created by tommytexter on 2022-07-31.
//

import Foundation
import Combine

class MovieSearch: ObservableObject {
    private let baseURL = "https://api.themoviedb.org/3"
    private let apiKey = "?api_key=2a8ac0dc7b78acc0f7e8917e80c2c94a"
    private let query = "&query="
    static let baseImageUrl = "https://image.tmdb.org/t/p/w600_and_h900_bestv2"
    @Published var movies: [Movie] = []
    @Published private(set) var isLoading = false
    @Published var searchingFor: String = ""
    private var bag = Set<AnyCancellable>()
    
    func fetchUsingCombine(for movie: String) {
        if movie != ""{
            if let searchURL = URL(string: baseURL+"/search/movie"+apiKey+query+movie.replacingOccurrences(of: " ", with: "+")){
                URLSession
                    .shared
                    .dataTaskPublisher(for: searchURL)
                    .receive(on: DispatchQueue.main)
                    .map(\.data)
                    .decode(type: Post.self, decoder: JSONDecoder())
                    .sink { res in
                        //to do
                    } receiveValue: { [weak self] newPost in
                        self?.movies = newPost.movies
                    }
                    .store(in: &bag)

                
            }
        }
    }
    
    func fetchTrending(for timeWindow: TimeWindow){
        print(baseURL+"/trending/all/"+timeWindow.rawValue+apiKey)
        if let searchURL = URL(string: baseURL+"/trending/movie/"+timeWindow.rawValue+apiKey){
            URLSession
                .shared
                .dataTaskPublisher(for: searchURL)
                .receive(on: DispatchQueue.main)
                .map(\.data)
                .decode(type: Post.self, decoder: JSONDecoder())
                .sink { res in
                    print(res)
                } receiveValue: { [weak self] newPost in
                    print("in setting")
                    self?.movies = newPost.movies
                }
                .store(in: &bag)

            
        }
    }
    
    // fetch simple
//    func fetch(for movie: String) -> Void {
//        if movie != ""{
//            if let url = URL(string: baseURL+apiKey+query+movie.replacingOccurrences(of: " ", with: "+")){
//                print("new movie in VM: \(movie)")
//                print("fetching for url: \(url)")
//                let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
//                    guard let data = data, error == nil else {
//                        print("We have following error")
//                        print(error ?? "hello error")
//                        return
//                    }
//                    do{
//                        let newPost = try JSONDecoder().decode(Post.self, from: data)
//                        DispatchQueue.main.async {
//                            print("in main queue")`
//                            self!.movies = newPost.movies
//                        }
//                    }
//                    catch{
//                        print(error)
//                    }
//                }
//                task.resume()
//            }
//            else{
//                print("error making search URL")
//            }
//        }
//    }
    
}


extension MovieSearch{
    enum TimeWindow: String {
        case day = "day"
        case week = "week"
    }
    
    enum SearchType: String {
        case movie = "movie"
        case tv = "tv"
        case people = "people"
    }
}
