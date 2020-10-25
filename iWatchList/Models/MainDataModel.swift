//
//  MainDataModel.swift
//  iWatchList
//
//  Created by Brian Gomes on 24/10/2020.
//

import Foundation

class MainDataModel:NSObject {
    let popularity: Double
    let voteCount: Int
    let posterPath: String
    let id: Int
    let adult: Bool
    let backdropPath: String
    let originalTitle: String
    let title: String
    let voteAverage: Double
    let overview, releaseDate: String

    init(popularity: Double, voteCount: Int, posterPath: String, id: Int, adult: Bool, backdropPath: String, originalTitle: String, title: String, voteAverage: Double, overview: String, releaseDate: String) {
        self.popularity = popularity
        self.voteCount = voteCount
        self.posterPath = posterPath
        self.id = id
        self.adult = adult
        self.backdropPath = backdropPath
        self.originalTitle = originalTitle
        self.title = title
        self.voteAverage = voteAverage
        self.overview = overview
        self.releaseDate = releaseDate
    }
}
