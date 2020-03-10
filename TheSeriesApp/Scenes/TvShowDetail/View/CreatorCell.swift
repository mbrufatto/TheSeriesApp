//
//  CreatorCell.swift
//  TheSeriesApp
//
//  Created by Marcio Habigzang Brufatto on 10/03/20.
//  Copyright © 2020 Marcio Habigzang Brufatto. All rights reserved.
//

import UIKit
import Kingfisher

class CreatorCell: UICollectionViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var creatorImage: UIImageView!
    
    func configure(_ creator: Creator) {
        
        creatorImage.layer.cornerRadius = 50
        
        if creator.profilePath.value != "" {
            let url = URL(string: APIConfig.baseImageUrl + creator.profilePath.value)
            self.creatorImage.kf.setImage(with: url)
        } else {
            self.creatorImage.image = UIImage(named: "ChuckNorris")
        }
        creator.name.bind { self.name.text = $0 }
    }
    
}
