//
//  ListTvShowViewController.swift
//  TheSeriesApp
//
//  Created by Marcio Habigzang Brufatto on 08/03/20.
//  Copyright © 2020 Marcio Habigzang Brufatto. All rights reserved.
//

import UIKit

class ListTvShowViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var tvShowViewModel = TvShowViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 164
        
        loadData()
    }
    
    private func loadData() {
        tvShowViewModel.loadTvShows(page: self.tvShowViewModel.page) { result in
            self.tableView.reloadData()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height {
            if self.tvShowViewModel.numberOfRows(0) < self.tvShowViewModel.totalPages {
                self.tvShowViewModel.page += 1
                self.loadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tvShowDetailSegue" {
            prepareSegueForTvShowDetailViewController(segue: segue)
        }
    }
    
    private func prepareSegueForTvShowDetailViewController(segue: UIStoryboardSegue) {
        guard let tvShowDetailViewController = segue.destination as? TvShowDetailViewController, let indexPath =
            self.tableView.indexPathForSelectedRow else {
                return
        }

        let tvshow = self.tvShowViewModel.tvShowAt(indexPath.row)
        tvShowDetailViewController.tvShow = tvshow
    }
}

extension ListTvShowViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tvShowViewModel.numberOfRows(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tvShowCell", for: indexPath) as! TvShowCell
        
        let tvShow = tvShowViewModel.tvShowAt(indexPath.row)
        cell.configureCell(tvShow)
        
        return cell
    }
}

extension ListTvShowViewController: UITableViewDelegate {
    
}
