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
    @IBOutlet weak var genres: UILabel!
    @IBOutlet weak var backgroundVoteAvarange: UIView!
    
    @IBOutlet weak var creatorsCollectionView: UICollectionView!
    @IBOutlet weak var similarTvShowCollectionView: UICollectionView!
    
    var tvShow: TvShow?
    fileprivate var tvShowDetailViewModel = TvShowDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        creatorsCollectionView.delegate = self
        creatorsCollectionView.dataSource = self
        
        similarTvShowCollectionView.delegate = self
        similarTvShowCollectionView.dataSource = self
        
        configureComponents()
        setupDatas()
        loadData()
        loadSimilarTvShowData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
    }
    
    private func configureComponents() {
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.backgroundColor = .clear
        
        self.poster.layer.borderColor = UIColor.white.cgColor
        self.poster.layer.borderWidth = 1.5
        self.poster.layer.cornerRadius = 5
        
        self.backgroundVoteAvarange.layer.cornerRadius = 10
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let layoutSimilarTvShow = UICollectionViewFlowLayout()
        layoutSimilarTvShow.scrollDirection = .horizontal
        
        self.creatorsCollectionView.collectionViewLayout = layout
        self.similarTvShowCollectionView.collectionViewLayout = layoutSimilarTvShow
    }
    
    private func loadData() {
        tvShowDetailViewModel.loadGenresAndCreators(tvShowId: (self.tvShow?.id.value)!) { creators in
            self.genres.text = self.tvShowDetailViewModel.genresString
            self.numberOfSessions.text = String(self.tvShowDetailViewModel.seasonNumber)
            self.creatorsCollectionView.reloadData()
        }
    }
    
    private func loadSimilarTvShowData() {
        tvShowDetailViewModel.loadSimilarTvShow(page: self.tvShowDetailViewModel.pageSimilarTvShow, tvShowId: self.tvShow!.id.value) { result in
            self.similarTvShowCollectionView.reloadData()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView === similarTvShowCollectionView {
            let offsetX = scrollView.contentOffset.x
            let contentWidth = scrollView.contentSize.width
            if offsetX > contentWidth - scrollView.frame.size.width {
                if self.tvShowDetailViewModel.numberOfRowsSimilarTvShow(0) < self.tvShowDetailViewModel.totalPagesSimilarTvShow {
                    self.tvShowDetailViewModel.pageSimilarTvShow += 1
                    self.loadSimilarTvShowData()
                }
            }
        }
    }

    private func setupDatas() {
        if let tvShow = self.tvShow {
            tvShow.name.bind { self.name.text = $0 }
            tvShow.overview.bind { self.overview.text = $0 }
            tvShow.voteAverage.bind { self.voteAvarange.text = String($0) }
            tvShow.firstAirDate.bind { self.firstAirDate.text = $0.getYearOfDate() }
            
            if !tvShow.posterPath.value.isEmpty {
                let posterURL = URL(string: APIConfig.baseImageUrl + tvShow.posterPath.value)
                self.poster.kf.setImage(with: posterURL )
            } else {
                self.poster.image = UIImage(named: "Shows")
            }
        
            if !tvShow.backdropPath.value.isEmpty {
                let backgroundImageURL = URL(string: APIConfig.baseImageUrl + tvShow.backdropPath.value)
                self.backgroundPoster.kf.setImage(with: backgroundImageURL )
            } else {
                self.backgroundPoster.image = UIImage(named: "background")
            }
        }
    }
}

extension TvShowDetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == creatorsCollectionView {
            return self.tvShowDetailViewModel.numberOfRowsCreators(section)
        } else if collectionView == similarTvShowCollectionView {
            return self.tvShowDetailViewModel.numberOfRowsSimilarTvShow(section)
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == creatorsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "creatorCell", for: indexPath) as! CreatorCell
            
            let creator = tvShowDetailViewModel.creatorAt(indexPath.row)
            cell.configure(creator)
            
            return cell
        } else if collectionView == similarTvShowCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "similarTvShowCell", for: indexPath) as! SimilarTvShowCell
            
            let similarTvShow = tvShowDetailViewModel.similarTvShowAt(indexPath.row)
            cell.configure(similarTvShow)
            
            return cell
        }
        
        return UICollectionViewCell()
    }
}

extension TvShowDetailViewController: UICollectionViewDelegate {
    
}

extension TvShowDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == similarTvShowCollectionView {
            return CGSize(width: 150.0, height: 201.0)
        } else if collectionView == creatorsCollectionView {
            return CGSize(width: 150.0, height: 150)
        } else {
            return CGSize(width: 0, height: 0)
        }
    }
}
