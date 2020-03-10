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
    private var creators: [Creator] = []
    private var similarTvShow: [SimilarTvShow] = []
    
    var genresString: String = ""
    var seasonNumber: Int = 0
    var totalPagesSimilarTvShow: Int = 0
    var pageSimilarTvShow: Int = 1
    
    func loadGenresAndCreators(tvShowId: Int, completion: @escaping([Genre]) -> ()) {
        let genreAndCreatorsUrl = APIConfig.baseUrl + "/\(tvShowId)?api_key=\(APIConfig.apiKey)&language=en-US"
        let genreAndCreatorsResource = Resource<GenresAndCreatorsBase>(url: genreAndCreatorsUrl, page: 0) { data in
            let genreAndCreatorsData = try? JSONDecoder().decode(GenresAndCreatorsBase.self, from: data)
            return genreAndCreatorsData
        }
        
        NetworkManager().load(resource: genreAndCreatorsResource) { result in
            if let genreAndCreatorsData = result {
                genreAndCreatorsData.seasonNumber.bind { self.seasonNumber = $0 }
                self.genres.append(contentsOf: genreAndCreatorsData.genres)
                self.creators.append(contentsOf: genreAndCreatorsData.creators)
                self.genresString = self.transformGenresInString()
                completion(genreAndCreatorsData.genres)
            } else {
                completion([Genre]())
            }
        }
    }
    
    func loadSimilarTvShow(page: Int, tvShowId: Int, completion: @escaping([SimilarTvShow]) -> ()) {
        
        let similarTvShowUrl = APIConfig.baseUrl + "/\(tvShowId)/similar?api_key=\(APIConfig.apiKey)&language=en-US&page=\(page)"
        let similarTvShowResource = Resource<SimilarTvShowBase>(url: similarTvShowUrl, page: page) { data in
            let similarTvShowData = try? JSONDecoder().decode(SimilarTvShowBase.self, from: data)
            return similarTvShowData
        }
        
        NetworkManager().load(resource: similarTvShowResource) { result in
            if let similarTvShowData = result {
                self.similarTvShow.append(contentsOf: similarTvShowData.results)
                similarTvShowData.totalPages.bind { self.totalPagesSimilarTvShow = $0 }
                completion(self.similarTvShow)
            } else {
                completion([SimilarTvShow]())
            }
        }
    }
    
    private func transformGenresInString() -> String {
        var genresString: String = ""
        
        for genre in genres {
            genresString.append(contentsOf: genre.name.value)
            genresString.append(contentsOf: " | ")
        }
        return String(genresString.trimmingCharacters(in: .whitespaces).dropLast())
    }
    
    func numberOfRowsCreators(_ section: Int) -> Int {
        return self.creators.count
    }
    
    func creatorAt(_ index: Int) -> Creator {
        return self.creators[index]
    }
    
    func numberOfRowsSimilarTvShow(_ section: Int) -> Int {
        return self.similarTvShow.count
    }
    
    func similarTvShowAt(_ index: Int) -> SimilarTvShow {
        return self.similarTvShow[index]
    }
}

