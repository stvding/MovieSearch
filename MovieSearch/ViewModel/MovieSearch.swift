//
//  MovieSearch.swift
//  MovieSearch
//
//  Created by tommytexter on 2022-07-31.
//

import Foundation

class MovieSearch: ObservableObject {
    let baseURL = "https://api.themoviedb.org/3/search/movie"
    let apiKey = "?api_key=2a8ac0dc7b78acc0f7e8917e80c2c94a"
    let query = "&query="
    static let baseImageUrl = "https://image.tmdb.org/t/p/w600_and_h900_bestv2"
    @Published var movies: [Movie] = []
    @Published var isLoading = false
    @Published var searchingFor: String = ""
    
    // fetch simple
    func fetch(for movie: String) -> Void {
        if movie != ""{
            if let url = URL(string: baseURL+apiKey+query+movie.replacingOccurrences(of: " ", with: "+")){
                print("new movie in VM: \(movie)")
                print("fetching for url: \(url)")
                let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                    guard let data = data, error == nil else {
                        print("We have following error")
                        print(error ?? "hello error")
                        return
                    }
                    do{
                        let newPost = try JSONDecoder().decode(Post.self, from: data)
                        DispatchQueue.main.async {
                            print("in main queue")
                            self!.movies = newPost.movies
                        }
                    }
                    catch{
                        print(error)
                    }
                }
                task.resume()
            }
            else{
                print("error making search URL")
            }
        }
    }
    
    // fetch binding
//    func fetchBinding(for movie: String) -> [Movie] {
//        $searchingFor.map { searchingFor in
//            self.fetch(for: searchingFor)
//        }
//        .assign(to: &$movies)
//
//
//
//        movies = []
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
//                            print("in main queue")
//                            return newPost.movies
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
//                return
//            }
//        }
//    }
}
