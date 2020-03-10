//
//  TvShowDetailViewModel.swift
//  TheSeriesApp
//
//  Created by Marcio Habigzang Brufatto on 09/03/20.
//  Copyright © 2020 Marcio Habigzang Brufatto. All rights reserved.
//

import Foundation

class TvShowDetailViewModel {
    
    private var genres: [Genre] = []
    
    var genresString: String = ""
    var seasonNumber: Int = 0
    
    func loadGenresAndCreators(tvShowId: Int, completion: @escaping([Genre]) -> ()) {
        let genreAndCreatorsUrl = APIConfig.baseUrl + "/\(tvShowId)?api_key=\(APIConfig.apiKey)&language=en-US"
        let genreAndCreatorsResource = Resource<GenresAndCreatorsBase>(url: genreAndCreatorsUrl, page: 0) { data in
            let genreAndCreatorsData = try? JSONDecoder().decode(GenresAndCreatorsBase.self, from: data)
            return genreAndCreatorsData
        }
        
        NetworkManager().load(resource: genreAndCreatorsResource) { result in
            if let genreAndCreatorsData = result {
//                genreAndCreatorsData.seasonNumber.bind { self.seasonNumber = $0 }
                self.genres.append(contentsOf: genreAndCreatorsData.genres)
                self.genresString = self.transformGenresInString()
                completion(genreAndCreatorsData.genres)
            } else {
                completion([Genre]())
            }
        }
    }
    
    private func transformGenresInString() -> String {
        var genresString: String = ""
        
        for genre in genres {
            genresString.append(contentsOf: genre.name.value)
            genresString.append(contentsOf: " - ")
        }
        return String(genresString.trimmingCharacters(in: .whitespaces).dropLast())
    }
}

