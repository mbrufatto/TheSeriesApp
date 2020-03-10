//
//  TvShowDetailViewController.swift
//  TheSeriesApp
//
//  Created by Marcio Habigzang Brufatto on 09/03/20.
//  Copyright © 2020 Marcio Habigzang Brufatto. All rights reserved.
//

import UIKit
import Kingfisher

class TvShowDetailViewController: UIViewController {

    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var backgroundPoster: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var numberOfSessions: UILabel!
    @IBOutlet weak var voteAvarange: UILabel!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var firstAirDate: UILabel!
    @IBOutlet weak var sessionNumber: UILabel!
    @IBOutlet weak var genres: UILabel!
    
    var tvShow: TvShow?
    fileprivate var tvShowDetailViewModel = TvShowDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.backgroundColor = .clear
        // Do any additional setup after loading the view.
        
        setupDatas()
        loadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Restore the navigation bar to default
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
    }
    
    private func loadData() {
        tvShowDetailViewModel.loadGenresAndCreators(tvShowId: (self.tvShow?.id.value)!) { creators in
            self.genres.text = self.tvShowDetailViewModel.genresString
            print(self.tvShowDetailViewModel.genresString)
        }
    }

    private func setupDatas() {
        if let tvShow = self.tvShow {
            tvShow.name.bind { self.name.text = $0 }
            tvShow.overview.bind { self.overview.text = $0 }
            tvShow.voteAverage.bind { self.voteAvarange.text = String($0) }
            tvShow.firstAirDate.bind { self.firstAirDate.text = $0 }
            
            let posterURL = URL(string: APIConfig.baseImageUrl + tvShow.posterPath.value)
            self.poster.kf.setImage(with: posterURL )
            
            let backgroundImageURL = URL(string: APIConfig.baseImageUrl + tvShow.backdropPath.value)
            self.backgroundPoster.kf.setImage(with: backgroundImageURL )
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
