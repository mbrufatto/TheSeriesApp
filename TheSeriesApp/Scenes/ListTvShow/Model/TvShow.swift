//
//  TvShow.swift
//  TheSeriesApp
//
//  Created by Marcio Habigzang Brufatto on 07/03/20.
//  Copyright © 2020 Marcio Habigzang Brufatto. All rights reserved.
//

import Foundation

class Dynamic<T>: Decodable where T: Decodable {
    
    typealias Listener = (T) -> ()
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(listener: @escaping Listener) {
        self.listener = listener
        self.listener?(self.value)
    }
    
    private enum CodingKeys: CodingKey {
        case value
    }
}

struct TvShow: Decodable {
    
    let id: Dynamic<Int>
    let name: Dynamic<String>
    let overview: Dynamic<String>
    let posterPath: Dynamic<String>
    let voteAverage: Dynamic<Double>
    let firstAirDate: Dynamic<String>
    let genreIds: Dynamic<[Int]>
    let originalName: Dynamic<String>
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = Dynamic(try container.decode(Int.self, forKey: .id))
        name = Dynamic(try container.decode(String.self, forKey: .name))
        overview = Dynamic(try container.decode(String.self, forKey: .overview))
        posterPath = Dynamic(try container.decode(String.self, forKey: .posterPath))
        voteAverage = Dynamic(try container.decode(Double.self, forKey: .voteAverage))
        firstAirDate = Dynamic(try container.decode(String.self, forKey: .firstAirDate))
        genreIds = Dynamic(try container.decode([Int].self, forKey: .genreIds))
        originalName = Dynamic(try container.decode(String.self, forKey: .originalName))
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case overview
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case firstAirDate = "first_air_date"
        case genreIds = "genre_ids"
        case originalName = "original_name"
    }
}

struct TvShowBase: Decodable {
    
    let results: [TvShow]
    let total_pages: Dynamic<Int>
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        results = try container.decode([TvShow].self, forKey: .results)
        total_pages = Dynamic(try container.decode(Int.self, forKey: .total_pages))
    }
    
    private enum CodingKeys: String, CodingKey {
        case results
        case total_pages
    }
}


