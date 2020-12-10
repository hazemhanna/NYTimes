//
//  Repository.swift
//  NYTimes
//
//  Created by Adel Aref on 10/12/2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import Foundation
protocol Repository {
    var networkClient: APIClient { get }
    var cacher: Cacher { get }

    func getData<T: Cachable>(withRequest: URLRequest,
                              name: String,
                              decodingType: T.Type,
                              completion: @escaping RepositoryCompletion)
        where T: Codable
}

extension Repository {
    typealias RepositoryCompletion = (RequestResult<Decodable, RequestError>) -> Void
    func getData<T: Cachable>(withRequest: URLRequest,
                              name: String,
                              decodingType: T.Type,
                              completion: @escaping RepositoryCompletion)
        where T: Codable {
            networkClient.makeRequest(withRequest: withRequest, decodingType: decodingType) { (result) in
                switch result {
                case .success(let data):
                    completion(result)
                default :
                    let cached: T? = self.cacher.load(fileName: name)
                    completion(.success(cached))
                    return
                }

            }
    }
}
