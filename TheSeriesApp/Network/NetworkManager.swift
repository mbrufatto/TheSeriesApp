//
//  NetworkManager.swift
//  TheSeriesApp
//
//  Created by Marcio Habigzang Brufatto on 06/03/20.
//  Copyright © 2020 Marcio Habigzang Brufatto. All rights reserved.
//

import Foundation

struct Resource<T> {
    let url: String
    let page: Int
    let parse: (Data) -> T?
    let error: (Error) -> T?
}


fileprivate struct APIConfig {
    static let apiKey = "6f4768c52238557ac6372ea46aefbb71"
}

final class NetworkManager {
    
    func load<T>(resource: Resource<T>, completion: @escaping(T?) -> Void) {
        
        let tvShowsUrl = URLComponents(string: resource.url)!
        var request = URLRequest(url: tvShowsUrl.url!)
        
        request.httpMethod = "GET"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    completion(resource.parse(data))
                }
            } else {
                completion(resource.error(error!))
            }
        }.resume()
    }
}
