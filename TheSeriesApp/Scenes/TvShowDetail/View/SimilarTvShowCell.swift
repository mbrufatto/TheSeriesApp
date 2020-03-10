//
//  SimilarTvShowCell.swift
//  TheSeriesApp
//
//  Created by Marcio Habigzang Brufatto on 10/03/20.
//  Copyright © 2020 Marcio Habigzang Brufatto. All rights reserved.
//

import UIKit

class SimilarTvShowCell: UICollectionViewCell {
    
    @IBOutlet weak var similarTvShowPoster: UIImageView!
    @IBOutlet weak var similarTvShowName: UILabel!
    
    func configure(_ similarTvShow: SimilarTvShow) {
        
        if similarTvShow.posterPath.value != "" {
            let url = URL(string: APIConfig.baseImageUrl + similarTvShow.posterPath.value)
            self.similarTvShowPoster.kf.setImage(with: url)
        } else {
            self.similarTvShowPoster.image = UIImage(named:"Shows")
        }
        
        similarTvShow.name.bind { self.similarTvShowName.text = $0 }
    }
}
