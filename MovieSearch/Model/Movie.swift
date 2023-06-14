//
//  Movie.swift
//  MovieSearch
//
//  Created by tommytexter on 2022-07-31.
//

import Foundation

struct Post: Codable {
    // testing git sync
    let page: Int
    let movies: [Movie]
    let totalPages: Int
    let totalResults: Int
    
    enum PostCodingKeys: String, CodingKey {
        case page
        case movies = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PostCodingKeys.self)
        self.page = try container.decode(Int.self, forKey: .page)
        self.movies = try container.decode([Movie].self, forKey: .movies)
        self.totalPages = try container.decode(Int.self, forKey: .totalPages)
        self.totalResults = try container.decode(Int.self, forKey: .totalResults)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: PostCodingKeys.self)
        try container.encode(self.page, forKey: .page)
        try container.encode(self.totalPages, forKey: .totalPages)
        try container.encode(self.totalResults, forKey: .totalResults)
    }
}


struct Movie: Codable, Hashable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let image: String?
    let backdrop: String?
    var rating: Int
    
    enum MovieDataKeys: String, CodingKey {
        case id,title,overview
        case image = "poster_path"
        case backdrop = "backdrop_path"
        case rating = "vote_average"
    }
    
    init(from decoder: Decoder) throws {
        let data = try decoder.container(keyedBy: MovieDataKeys.self)

        
        self.id = try data.decode(Int.self, forKey: .id)
        self.title = try data.decode(String.self, forKey: .title)
        self.overview = try data.decode(String.self, forKey: .overview)
        self.image = try data.decode(String?.self, forKey: .image)
        self.backdrop = try data.decode(String?.self, forKey: .backdrop)
        self.rating = try Int(data.decode(Double.self, forKey: .rating) * 10)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: MovieDataKeys.self)
        try container.encode(self.id, forKey: .id)
        
        try container.encode(self.title, forKey: .title)
        try container.encode(self.overview, forKey: .overview)
        try container.encode(self.image, forKey: .image)
        try container.encode(self.backdrop, forKey: .backdrop)
        try container.encode(self.rating, forKey: .rating)
    }
}
