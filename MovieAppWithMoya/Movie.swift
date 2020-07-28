//
//  Movie.swift
//  MovieAppWithMoya
//
//  Created by iDev0 on 2020/07/28.
//  Copyright © 2020 Ju Young Jung. All rights reserved.
//

import Foundation


struct Movie: Codable {
    
    let id: Int
    let posterPath: String?
    let adult: Bool
    let overview: String
    let releaseDate: String
    let genreIds: [Int]
    let originalTitle: String
    let originalLanguage: String
    let title: String
    let backdropPath: String?
    let popularity: Float
    let voteCount: Int
    let video: Bool
    let voteAverage: Float
    
    enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case adult
        case overview
        case releaseDate = "release_date"
        case genreIds = "genre_ids"
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case title
        case backdropPath = "backdrop_path"
        case popularity
        case voteCount = "vote_count"
        case video
        case voteAverage = "vote_average"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id                  = try values.decode(Int.self, forKey: .id)
        posterPath          = try values.decode(String?.self, forKey: .posterPath)
        adult               = try values.decode(Bool.self, forKey: .adult)
        overview            = try values.decode(String.self, forKey: .overview)
        releaseDate         = try values.decode(String.self, forKey: .releaseDate)
        genreIds            = try values.decode([Int].self, forKey: .genreIds)
        originalTitle       = try values.decode(String.self, forKey: .originalTitle)
        originalLanguage    = try values.decode(String.self, forKey: .originalLanguage)
        title               = try values.decode(String.self, forKey: .title)
        backdropPath        = try values.decode(String?.self, forKey: .backdropPath)
        popularity          = try values.decode(Float.self, forKey: .popularity)
        voteCount           = try values.decode(Int.self, forKey: .voteCount)
        video               = try values.decode(Bool.self, forKey: .video)
        voteAverage         = try values.decode(Float.self, forKey: .voteAverage)
    }
}


struct MovieDataStore: Codable {
    let results: [Movie]
}
