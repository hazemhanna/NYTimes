//
//  File.swift
//  NYTimes
//
//  Created by MAC on 12/10/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import Foundation
class ArticalRepository: Repository {
    
    let cacher: Cacher
    let networkClient: APIClient

    public init(_ client: APIClient = NetworkClient()) {
        networkClient = client
        cacher = Cacher(destination: .atFolder("Artical"))
    }
    func getArticalList( completion: @escaping RepositoryCompletion) {
        guard let url = Endpoint.getArtical().url else { return }
        let request = makeRequest(url: url, parameters: nil, type: .post)
        getData(withRequest: request,
        name: String(describing: ArticalesModelJSON.self),
        decodingType: ArticalesModelJSON.self,
        completion: completion)
    }
}
