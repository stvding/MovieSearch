//
//  ContentView.swift
//  MovieSearch
//
//  Created by tommytexter on 2022-07-31.
//

import SwiftUI

struct ContentView: View {
    @StateObject var search = MovieSearch()
    
    var body: some View {
        NavigationView{
            List{
                ForEach(search.movies) { movie in
                    MovieCell(for: movie)
                }
            }
            .navigationBarTitle(Text("My App"))
            .onAppear {
                print("Staring up")
                search.fetchTrending(for: .day)
            }
        }
        .searchable(text: $search.searchingFor, prompt: "Look for movies?")
        .onChange(of: search.searchingFor) { newMovie in
            print("new movie in view: \(newMovie)")
            search.fetchUsingCombine(for: newMovie)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
