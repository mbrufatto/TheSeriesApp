//
//  TvShowDetailTest.swift
//  TheSeriesAppTests
//
//  Created by Marcio Habigzang Brufatto on 10/03/20.
//  Copyright © 2020 Marcio Habigzang Brufatto. All rights reserved.
//

import XCTest
@testable import TheSeriesApp

class TvShowDetailTest: XCTestCase {

    private var tvShowDetailViewModel: TvShowDetailViewModel!
    
    override func setUp() {
        super.setUp()
        tvShowDetailViewModel = TvShowDetailViewModel()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testAddCreators() {
        tvShowDetailViewModel.addCreators(didLoadCreators(nameFile: "detail"))
        XCTAssertEqual(tvShowDetailViewModel.numberOfRowsCreators(0), 4)
    }
    
    func testAddGenres() {
        tvShowDetailViewModel.addGenres(didLoadGenres(nameFile: "detail"))
        XCTAssertEqual(tvShowDetailViewModel.numberOfRowsCreators(0), 3)
    }
    
    func testAddSimilarTvShow() {
        tvShowDetailViewModel.addSimilarTvShow(didLoadSimilarTvShow(nameFile: "similarTvShow"))
        XCTAssertEqual(tvShowDetailViewModel.numberOfRowsCreators(0), 20)
    }
    
    func testSelectedCreator() {
        tvShowDetailViewModel.addCreators(didLoadCreators(nameFile: "detail"))
        let creator = tvShowDetailViewModel.creatorAt(1)
        
        XCTAssertEqual(creator.name.value, "Donald Wilson")
    }
    
    func testSelectedSimilarTvShow() {
        tvShowDetailViewModel.addSimilarTvShow(didLoadSimilarTvShow(nameFile: "similarTvShow"))
        let similarTvShow = tvShowDetailViewModel.similarTvShowAt(0)
        
        XCTAssertEqual(similarTvShow.name.value, "Doctor Who")
    }
    
    func testTransformGenresInString() {
        tvShowDetailViewModel.addGenres(didLoadGenres(nameFile: "detail"))
        let genreString = tvShowDetailViewModel.transformGenresInString()
        
        XCTAssertEqual(genreString, "Action & Adventure | Drama | Sci-Fi & Fantasy")
    }
    
    
    private func didLoadCreators(nameFile: String) -> [Creator] {
        let bundle = Bundle(for: type(of: self))
        if let url = bundle.url(forResource: nameFile, withExtension: "json") {
            
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(GenresAndCreatorsBase.self, from: data)
                return jsonData.creators
            } catch {
                return []
            }
        }
        return []
    }
    
    private func didLoadGenres(nameFile: String) -> [Genre] {
        let bundle = Bundle(for: type(of: self))
        if let url = bundle.url(forResource: nameFile, withExtension: "json") {
            
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(GenresAndCreatorsBase.self, from: data)
                return jsonData.genres
            } catch {
                return []
            }
        }
        return []
    }
    
    private func didLoadSimilarTvShow(nameFile: String) -> [SimilarTvShow] {
        let bundle = Bundle(for: type(of: self))
        if let url = bundle.url(forResource: nameFile, withExtension: "json") {
            
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(SimilarTvShowBase.self, from: data)
                return jsonData.results
            } catch {
                return []
            }
        }
        return []
    }

}
