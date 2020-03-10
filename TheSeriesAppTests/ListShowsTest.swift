//
//  ListShowsTest.swift
//  TheSeriesAppTests
//
//  Created by Marcio Habigzang Brufatto on 10/03/20.
//  Copyright © 2020 Marcio Habigzang Brufatto. All rights reserved.
//

import XCTest
@testable import TheSeriesApp

class TheSeriesAppTests: XCTestCase {

    private var tvShowViewModel: TvShowViewModel!
    
    override func setUp() {
        super.setUp()
        tvShowViewModel = TvShowViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testLoadTvShows() {
        tvShowViewModel.updateTvShow(tvShows: didLoadTvShow(nameFile: "shows"))
        XCTAssertEqual(tvShowViewModel.numberOfRows(0), 20)
    }
    
    func testSecondLoadTvShows() {
        tvShowViewModel.updateTvShow(tvShows: didLoadTvShow(nameFile: "shows"))
        tvShowViewModel.updateTvShow(tvShows: didLoadTvShow(nameFile: "shows2"))
        XCTAssertEqual(tvShowViewModel.numberOfRows(0), 40)
    }
    
    func testSelectTvShow() {
        var tvShowName = ""
        tvShowViewModel.updateTvShow(tvShows: didLoadTvShow(nameFile: "shows"))
        
        let tvshow = tvShowViewModel.tvShowAt(0)
        tvshow.name.bind { tvShowName = $0 }
        
        XCTAssertEqual(tvShowName, "How to Get Away with Murder")
    }
    
    private func didLoadTvShow(nameFile: String) -> [TvShow] {
        let bundle = Bundle(for: type(of: self))
        if let url = bundle.url(forResource: nameFile, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(TvShowBase.self, from: data)
                return jsonData.results
            } catch {
                return []
            }
        }
        return []
    }
}
