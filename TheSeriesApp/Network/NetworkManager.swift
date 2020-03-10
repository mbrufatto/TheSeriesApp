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
}

final class NetworkManager {
    
    func load<T>(resource: Resource<T>, completion: @escaping(T?) -> ()) {
        
        var tvShowsUrl = URLComponents(string: resource.url)!
        var request = URLRequest(url: tvShowsUrl.url!)
        tvShowsUrl.queryItems?.append(URLQueryItem(name: "api_key", value: "\(APIConfig.apiKey)"))
        
        if resource.page > 0 {
            tvShowsUrl.queryItems?.append(URLQueryItem(name: "page", value: "\(resource.page)"))
        }
        
        let finalURL = tvShowsUrl.url
        request = URLRequest(url: finalURL!)
        
        request.httpMethod = "GET"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    completion(resource.parse(data))
                }
            } else {
                completion(nil)
            }
        }.resume()
    }
}

