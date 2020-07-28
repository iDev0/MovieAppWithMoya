//
//  MovieService.swift
//  MovieAppWithMoya
//
//  Created by iDev0 on 2020/07/26.
//  Copyright © 2020 Ju Young Jung. All rights reserved.
//

import Foundation
import Moya

enum MovieService {
    case nowPlaying
    case popular
    case detail(id: Int)
    case upcoming
}


extension MovieService : TargetType {
    
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3/movie")!
    }
    
    var path: String {
        switch self {
        case .nowPlaying:
            return "/now_playing"
        case .detail(let id):
            return "/\(id)"
        case .popular:
            return "/popular"
        case .upcoming:
            return "/upcoming"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .nowPlaying, .detail(_), .popular, .upcoming:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .nowPlaying, .detail(_), .popular, .upcoming:
            return Data()
        }
    }
    
    var task: Task {
        switch self {
        case .nowPlaying, .popular, .upcoming, .detail(_):
            return .requestParameters(parameters: ["api_key" : "24ca04c6a3c3f77dcd86b12fdef8c829"], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type" : "application/json"]
    }
    
    
}


