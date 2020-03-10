//
//  TvShowCell.swift
//  TheSeriesApp
//
//  Created by Marcio Habigzang Brufatto on 08/03/20.
//  Copyright © 2020 Marcio Habigzang Brufatto. All rights reserved.
//

import UIKit
import Kingfisher

class TvShowCell: UITableViewCell {

    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var voteAverage: UILabel!
    @IBOutlet weak var firstAirDate: UILabel!
    
    @IBOutlet weak var backgroundVoteAverage: UIView!
    
    fileprivate var tvShowViewModel = TvShowViewModel()
    
    func configureCell(_ tvShow: TvShow) {
        self.configurePoster(tvShow.posterPath.value)
        
        tvShow.name.bind { self.name.text = $0 }
        tvShow.overview.bind { self.overview.text = $0 }
        tvShow.voteAverage.bind { self.voteAverage.text = String($0) }
        
        tvShow.firstAirDate.bind { self.firstAirDate.text =  self.tvShowViewModel.getFormattedDate(date: $0) }
    }
    
    private func configurePoster(_ posterPath: String) {
        poster.layer.masksToBounds = true
        poster.layer.borderWidth = 1.5
        poster.layer.borderColor = UIColor.white.cgColor
        poster.layer.cornerRadius = 5
        
        backgroundVoteAverage.layer.cornerRadius = 10
        
        let url = URL(string: APIConfig.baseImageUrl + posterPath)
        self.poster.kf.setImage(with: url)
    }
}
