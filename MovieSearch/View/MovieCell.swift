//
//  MovieCell.swift
//  MovieSearch
//
//  Created by tommytexter on 2022-07-31.
//

import SwiftUI

struct MovieCell: View {
    var movie: Movie
    
    init(for movie: Movie){
        self.movie = movie
    }
    
    var body: some View{
        HStack{
            if let imageURL = movie.image{
                AsyncImage(url: URL(string: MovieSearch.baseImageUrl + imageURL)) { image in
                    image.resizable()
                } placeholder: {
                    Image("poster-placeholder")
                        .resizable()
                        .frame(maxWidth:80, maxHeight:120)
                        .scaledToFit()
                        .aspectRatio(contentMode: .fit)
                }
                .frame(maxWidth:80, maxHeight:120)
                .scaledToFit()
                .aspectRatio(contentMode: .fit)
                .onAppear {
                    print("Image fetched.")
                }
            }
            else{
                Image("poster-placeholder")
                    .resizable()
                    .frame(maxWidth:80, maxHeight:120)
                    .scaledToFit()
                    .aspectRatio(contentMode: .fit)
            }
            
            
            VStack(alignment: .leading){
                Text(movie.title)
                    .font(.title3)
                    .fontWeight(.bold)
                Text("Rating: \(movie.rating)%")
                    .font(.subheadline)
                    .fontWeight(.light)
                Text(movie.overview)
                    .lineLimit(4)
                    .font(.body)
                
            }
            .padding()
        }
    }
}
