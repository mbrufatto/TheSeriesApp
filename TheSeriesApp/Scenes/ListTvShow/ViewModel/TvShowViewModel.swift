//
//  TvShowModelView.swift
//  TheSeriesApp
//
//  Created by Marcio Habigzang Brufatto on 07/03/20.
//  Copyright © 2020 Marcio Habigzang Brufatto. All rights reserved.
//

import Foundation

class TvShowViewModel {
    
    private var tvShows: [TvShow] = []
    
    var totalPages: Int = 0
    var page: Int = 1
    
    func numberOfRows(_ section: Int) -> Int {
        return self.tvShows.count
    }
    
    func tvShowAt(_ index: Int) -> TvShow {
        return self.tvShows[index]
    }
    
    func loadTvShows(page: Int, completion: @escaping([TvShow]) -> ()) {
        let tvShowUrl = APIConfig.baseUrl + "/popular?api_key=\(APIConfig.apiKey)&language=en-US&page=\(page)"
        let tvShowResource = Resource<TvShowBase>(url: tvShowUrl, page: page) { data in
            let tvShowData = try? JSONDecoder().decode(TvShowBase.self, from: data)
            return tvShowData
        }
        
        NetworkManager().load(resource: tvShowResource) { result in
            if let tvShowData = result {
                self.updateTvShow(tvShows: tvShowData.results)
                tvShowData.totalPages.bind { self.totalPages = $0 }
                completion(self.tvShows)
            } else {
                completion([TvShow]())
            }
        }
    }
    
    func updateTvShow(tvShows: [TvShow]) {
        for tvShow in tvShows {
            if !self.tvShows.contains(where: { $0.id.value == tvShow.id.value }) {
                self.tvShows.append(tvShow)
            }
        }
    }
}

