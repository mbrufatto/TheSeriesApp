//
//  SimilarTvShow.swift
//  TheSeriesApp
//
//  Created by Marcio Habigzang Brufatto on 10/03/20.
//  Copyright © 2020 Marcio Habigzang Brufatto. All rights reserved.
//

import Foundation

struct SimilarTvShow: Decodable {

    let name: Dynamic<String>
    let posterPath: Dynamic<String>
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = Dynamic(try container.decodeIfPresent(String.self, forKey: .name) ?? "")
        posterPath = Dynamic(try container.decodeIfPresent(String.self, forKey: .posterPath) ?? "")
    }
    
    private enum CodingKeys: String, CodingKey {
        case name
        case posterPath = "poster_path"
    }
}


struct SimilarTvShowBase: Decodable {
    
    let totalPages: Dynamic<Int>
    let results: [SimilarTvShow]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        results = try container.decode([SimilarTvShow].self, forKey: .results)
        totalPages = Dynamic(try container.decode(Int.self, forKey: .totalPages))
    }
    
    private enum CodingKeys: String, CodingKey {
        case totalPages = "total_pages"
        case results
    }
    
}
