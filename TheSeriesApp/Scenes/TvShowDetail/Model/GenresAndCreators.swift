//
//  GenresAndCreators.swift
//  TheSeriesApp
//
//  Created by Marcio Habigzang Brufatto on 09/03/20.
//  Copyright © 2020 Marcio Habigzang Brufatto. All rights reserved.
//

import Foundation

struct Creator: Decodable {
    let id: Dynamic<Int>
    let name: Dynamic<String>
    let profilePath: Dynamic<String>
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = Dynamic(try container.decodeIfPresent(Int.self, forKey: .id) ?? 0)
        name = Dynamic(try container.decodeIfPresent(String.self, forKey: .name) ?? "")
        profilePath = Dynamic(try container.decodeIfPresent(String.self, forKey: .profilePath) ?? "")
    }
        
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case profilePath = "profile_path"
    }
}

struct Genre: Decodable {
        
    let id: Dynamic<Int>
    let name: Dynamic<String>
        
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = Dynamic(try container.decodeIfPresent(Int.self, forKey: .id) ?? 0)
        name = Dynamic(try container.decodeIfPresent(String.self, forKey: .name) ?? "")
    }
        
    private enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}

struct GenresAndCreatorsBase: Decodable {
    
    let genres: [Genre]
    let creators: [Creator]
    let seasonNumber: Dynamic<Int>
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        genres = try container.decode([Genre].self, forKey: .genres)
        creators = try container.decode([Creator].self, forKey: .creators)
        seasonNumber = Dynamic(try container.decode(Int.self, forKey: .seasonNumber))
    }
    
    private enum CodingKeys: String, CodingKey {
        case genres
        case creators = "created_by"
        case seasonNumber = "number_of_seasons"
    }
    
}

